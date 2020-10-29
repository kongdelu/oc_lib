//
//  DLTimer.m
//  oc_lib
//
//  Created by KDL on 2020/10/29.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "DLTimer.h"

static NSMutableDictionary *timerMap_;
static dispatch_semaphore_t semaphore_;

@implementation DLTimer

// 类第一次接收到消息时调用
+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timerMap_ = [[NSMutableDictionary alloc] init];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)execTask:(void(^)(void))task start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeating:(BOOL)repeating async:(BOOL)async {
    if (!task || start < 0 || (repeating && interval <= 0)) return nil;
    
    // 创建串行队列
    dispatch_queue_t queue = async ? dispatch_get_global_queue(0, 0) : dispatch_get_main_queue();
    
    // 创建定时器
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置时间
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, start * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0);
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    // 任务的Id
    NSString *taskId = [NSString stringWithFormat:@"%zd", timerMap_.count];
    [timerMap_ setObject:timer forKey:taskId];
    
    dispatch_semaphore_signal(semaphore_);
    
    // 设置事件回调
    dispatch_source_set_event_handler(timer, ^{
        task();
        if (!repeating) {
            [self cancelTask:taskId];
        }
    });
    
    // 启动定时器
    dispatch_resume(timer);
    
    return taskId;
}

+ (NSString *)execTask:(id)target selector:(SEL)selector start:(NSTimeInterval)start interval:(NSTimeInterval)interval repeating:(BOOL)repeating async:(BOOL)async {
    if (!target || !selector) return nil;
    
    return [self execTask:^{
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        if ([target respondsToSelector:selector]) {
            [target performSelector:selector];
        }
        #pragma clang diagnostic push
    } start:start interval:interval repeating:repeating async:async];
}

+ (void)cancelTask:(NSString *)task {
    if (task.length <= 0) return;
    
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    dispatch_source_t timer = [timerMap_ objectForKey:task];
    if (timer) {
        dispatch_source_cancel(timer);
        [timerMap_ removeObjectForKey:task];
    }
    dispatch_semaphore_signal(semaphore_);
}

@end
