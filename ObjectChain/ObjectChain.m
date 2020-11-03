//
//  ObjectChain.m
//  Runner
//
//  Created by ios on 2020/10/21.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "ObjectChain.h"

@implementation ObjectChain

- (NSMutableArray *)targets {
    if (_targets == nil) {
        _targets = [NSMutableArray array];
    }
    return _targets;
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    for (id object in self.targets) {
        if (object) {
            [anInvocation setTarget:object];
            NSString *mgs = self.msg;
            [anInvocation setArgument:&mgs atIndex:2];
            [anInvocation setSelector:@selector(messageMethod:)];
            [anInvocation invoke];
        }
    }
}

@end
