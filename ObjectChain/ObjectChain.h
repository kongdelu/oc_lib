//
//  ObjectChain.h
//  Runner
//
//  Created by ios on 2020/10/21.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ObjectChainProtocal <NSObject>

@optional
- (void)postMessage;//不需要实现
@required
- (void)messageMethod:(nullable NSString *)msg;//需要实现

@end

NS_ASSUME_NONNULL_BEGIN

@interface ObjectChain : NSObject

@property (nonatomic, strong) NSMutableArray *targets;
@property (nonatomic, copy) NSString *msg;
@end

NS_ASSUME_NONNULL_END
