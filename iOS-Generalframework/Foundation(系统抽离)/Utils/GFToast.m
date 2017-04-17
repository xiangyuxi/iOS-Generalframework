//
//  GFToast.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFToast.h"
#import "GF_Tools.h"

@interface GFToastCake : CALayer

@property (nonatomic, copy) UIColor *cakeColor;
@property (nonatomic, copy) CALayer *outeringLayer;
@property (nonatomic, copy) CAShapeLayer *insideringLayer;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
- (instancetype)initWithFrame:(CGRect)frame;

@end

@implementation GFToastCake {
    CALayer *_insideCakeLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super init])
    {
        self.frame = frame;
        [self initializer];
    }
    return self;
}

- (void)initializer
{
    CGFloat diameter = MIN(self.width, self.height);
    _outeringLayer = [CALayer layer];
    _outeringLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    _outeringLayer.position = CGPointMake(self.width/2, self.height/2);
    _outeringLayer.borderColor = [UIColor whiteColor].CGColor;
    _outeringLayer.borderWidth = 2.f;
    _outeringLayer.cornerRadius = diameter/2;
    [self addSublayer:_outeringLayer];
    
    diameter -= 4;
    _insideCakeLayer = [CALayer layer];
    _insideCakeLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    _insideCakeLayer.position = CGPointMake(self.width/2, self.height/2);
    _insideCakeLayer.backgroundColor = [UIColor whiteColor].CGColor;
    [self addSublayer:_insideCakeLayer];
    
    _insideringLayer = [CAShapeLayer layer];
    _insideringLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    _insideringLayer.position = CGPointMake(diameter/2, diameter/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(diameter/2, diameter/2)
                                                        radius:diameter/4
                                                    startAngle:gf_degrees_2_radian(-90)
                                                      endAngle:gf_degrees_2_radian(270)
                                                     clockwise:YES];
    _insideringLayer.lineWidth = diameter/2;
    _insideringLayer.path = path.CGPath;
    _insideringLayer.fillColor = [UIColor clearColor].CGColor;
    _insideringLayer.strokeColor = [UIColor redColor].CGColor;
    _insideringLayer.strokeEnd = 0;
    _insideCakeLayer.mask = _insideringLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 4;
    animation.toValue = @(1);
    [_insideringLayer addAnimation:animation forKey:nil];
    
}

- (void)setCakeColor:(UIColor *)cakeColor
{
    if (![_cakeColor isEqual:cakeColor])
    {
        _cakeColor = cakeColor;
        _insideCakeLayer.backgroundColor = cakeColor.CGColor;
        _outeringLayer.borderColor = cakeColor.CGColor;
    }
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

@end

@implementation GFToast

@end
