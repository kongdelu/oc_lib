//
//  DLTimer.h
//  oc_lib
//
//  Created by KDL on 2020/10/29.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

/*
 NSTimer依赖于RunLoop，如果RunLoop的任务过于繁重，可能会导致NSTimer不准时;
 使用GCD定时器(与Runloop没啥关系，直接调用内核函数).
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DLTimer : NSObject

+ (NSString *)execTask:(void(^)(void))task
                  start:(NSTimeInterval)start
               interval:(NSTimeInterval)interval
              repeating:(BOOL)repeating
                  async:(BOOL)async;

+ (NSString *)execTask:(id)target
                  selector:(SEL)selector
                  start:(NSTimeInterval)start
               interval:(NSTimeInterval)interval
              repeating:(BOOL)repeating
                  async:(BOOL)async;

+ (void)cancelTask:(NSString *)task;

@end

NS_ASSUME_NONNULL_END
