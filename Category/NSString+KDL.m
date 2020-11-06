//
//  NSString+KDL.m
//  Bhex
//
//  Created by ios on 2020/9/21.
//  Copyright © 2020 Bhex. All rights reserved.
//

#import "NSString+KDL.h"

@implementation NSString(KDL)


- (NSString*)removeFloatAllZero {
    NSString * outNumber = [NSString stringWithFormat:@"%@",@(self.floatValue)];
    return outNumber;
}
- (BOOL)isNull {
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

+ (NSMutableAttributedString *)attributedStringWithItems:(NSMutableArray *)items {
    
    NSString *sumString = @"";
    for (NSInteger i=0; i < items.count; i ++) {
        NSDictionary *dict = items[i];
        sumString = [NSString stringWithFormat:@"%@%@", sumString, dict[@"string"]];
    }
    
    NSMutableAttributedString *sumAttributedString = [[NSMutableAttributedString alloc]initWithString:sumString];
    NSInteger startCount = 0;
    for (NSInteger i=0; i < items.count; i ++) {
        NSDictionary *dict = items[i];
        NSString *itemString = dict[@"string"];
        NSRange rangel = NSMakeRange(startCount, itemString.length);
        [sumAttributedString addAttribute:NSForegroundColorAttributeName value:dict[@"color"] range:rangel];
        [sumAttributedString addAttribute:NSFontAttributeName value:dict[@"font"] range:rangel];
        startCount += itemString.length;
    }
    return sumAttributedString;
}

- (BOOL)inputString:(NSString *)string1 replacementString:(NSString *)string2 {
    NSArray *arrStr = [[string1 stringByAppendingString:string2] componentsSeparatedByString:@"."];
    if (arrStr.count < 2) {
        //如果没有小数点
        return YES;
    }
    //只允许输入一个小数点
    if ([string1 containsString:@"."] && [string2 isEqualToString:@"."]) {
        return NO;
    }
    //获取当前币的价格精度
    NSString *precision = [self currentPricePrecision];
    NSArray *precisionArray = [precision componentsSeparatedByString:@"."];
    NSInteger afterDotNum = 10;//默认小数点后10位
    if (precisionArray.count == 2) {
        afterDotNum = [precisionArray[1] length];
    }
    if ([arrStr[1] length] > afterDotNum) {
        NSString *str1 = arrStr.lastObject;
        if (str1.length > afterDotNum) {
            return NO;
        }
    }
    return YES;
}
@end
