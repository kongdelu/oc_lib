//
//  UIColor+Additions.h
//  MLIPhone
//
//  Created by yakehuang on 5/6/14.
//
//

#import <UIKit/UIKit.h>

#define moneyGreen @"#2ccc91"
#define Color(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define Color_Str(HexStr) [UIColor colorWithHex:HexStr]
@interface UIColor (Additions)

+ (UIColor*)colorWithHex:(NSString *)hexColor;
+ (UIColor*)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha;

+ (UIColor*)colorWithHue:(CGFloat)h saturation:(CGFloat)s value:(CGFloat)v alpha:(CGFloat)a;

//+ (UIColor*)colorWithR:(NSInteger)red G:(NSInteger)green B:(NSInteger)blue A:(CGFloat)alpha;

- (UIColor*)multiplyHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd;

- (UIColor*)addHue:(CGFloat)hd saturation:(CGFloat)sd value:(CGFloat)vd;

- (UIColor*)copyWithAlpha:(CGFloat)newAlpha;

/**
 * Uses multiplyHue to create a lighter version of the color.
 */
- (UIColor*)highlight;

/**
 * Uses multiplyHue to create a darker version of the color.
 */
- (UIColor*)shadow;

- (CGFloat)hue;

- (CGFloat)saturation;

- (CGFloat)value;

@end
