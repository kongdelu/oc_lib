//
//  NSString+KDL.h
//  Bhex
//
//  Created by ios on 2020/9/21.
//  Copyright © 2020 Bhex. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString(KDL)

/**浮点数去掉小数点之后多余的0*/
- (NSString *)removeFloatAllZero;

- (BOOL)isNull;

/**生成AttributeString
 
 NSMutableArray *itemsArray = [NSMutableArray array];
 itemsArray[0] = @{@"string":str1, @"color":color1, @"font":font1};
 itemsArray[1] = @{@"string":str2, @"color":color2, @"font":font2};
 */
+ (NSMutableAttributedString *)attributedStringWithItems:(NSMutableArray *)items;

/** 指定输入小数点位数
 
 return: YES 可以输入 NO 禁止输入
 */
- (BOOL)inputString:(NSString *)string1 replacementString:(NSString *)string2;

@end

NS_ASSUME_NONNULL_END
