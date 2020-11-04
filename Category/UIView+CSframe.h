

#import <UIKit/UIKit.h>

@interface UIView (CSframe)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property(nonatomic,strong,readonly) UIViewController *viewController;

-(CGFloat)x;

-(CGFloat)y;

-(CGFloat)width;

-(CGFloat)height;


-(void)setX:(CGFloat)x;

-(void)setY:(CGFloat)y;

-(void)setWidth:(CGFloat)width;

-(void)setHeight:(CGFloat)height;

@end
