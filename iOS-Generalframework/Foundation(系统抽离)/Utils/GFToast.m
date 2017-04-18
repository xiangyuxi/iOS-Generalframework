//
//  GFToast.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFToast.h"
#import "GF_Headers.h"
#import "GFEffectView.h"
#import "NSString+Size.h"

/* ---------------------------base------------------------------- */

@interface GFToastBaseLayer : CALayer

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)initializer;

@end

@implementation GFToastBaseLayer

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super init])
    {
        self.frame = frame;
        [self initializer];
    }
    return self;
}

- (void)initializer {}


- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

@end

/* ---------------------------cake------------------------------- */

@interface GFToastCake : GFToastBaseLayer

@property (nonatomic, copy) UIColor *cakeColor;
@property (nonatomic, copy) CALayer *outeringLayer;
@property (nonatomic, copy) CAShapeLayer *insideringLayer;

@end

@implementation GFToastCake {
    CALayer *_insideCakeLayer;
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
    
    diameter -= 8;
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

@end

/* ---------------------------horizontal bar------------------------------- */

@interface GFToastHbar : GFToastBaseLayer

@property (nonatomic, copy) UIColor *hbarColor;
@property (nonatomic, copy) CALayer *outerLayer;
@property (nonatomic, copy) CAShapeLayer *insideLayer;

@end

@implementation GFToastHbar {
    CALayer *_insideProgressLayer;
}

- (void)initializer
{
    _outerLayer = [CALayer layer];
    _outerLayer.frame = self.bounds;
    _outerLayer.borderColor = [UIColor whiteColor].CGColor;
    _outerLayer.borderWidth = 2.f;
    _outerLayer.cornerRadius = self.height/2;
    [self addSublayer:_outerLayer];
    
    _insideProgressLayer = [CALayer layer];
    _insideProgressLayer.bounds = CGRectMake(0, 0, self.width-8, self.height-8);
    _insideProgressLayer.position = CGPointMake(self.width/2, self.height/2);
    _insideProgressLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _insideProgressLayer.cornerRadius = (self.height-8)/2;
    [self addSublayer:_insideProgressLayer];
    
    CGSize size = _insideProgressLayer.bounds.size;
    _insideLayer = [CAShapeLayer layer];
    _insideLayer.frame = _insideProgressLayer.bounds;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, size.height/2)];
    [path addLineToPoint:CGPointMake(size.width, size.height/2)];
    [path closePath];
    _insideLayer.path = path.CGPath;
    _insideLayer.cornerRadius = size.height/2;
    _insideLayer.lineWidth = size.height;
    _insideLayer.fillColor = [UIColor clearColor].CGColor;
    _insideLayer.strokeColor = [UIColor redColor].CGColor;
    _insideLayer.strokeEnd = 0;
    _insideProgressLayer.mask = _insideLayer;
}

- (void)setHbarColor:(UIColor *)hbarColor
{
    if (![_hbarColor isEqual:hbarColor])
    {
        _hbarColor = hbarColor;
        _insideProgressLayer.backgroundColor = hbarColor.CGColor;
        _outerLayer.borderColor = hbarColor.CGColor;
    }
}

@end

/* ---------------------------annular------------------------------- */

@interface GFToastAnnular : GFToastBaseLayer

@property (nonatomic, copy) UIColor *annularColor;
@property (nonatomic, copy) CAShapeLayer *ringLayer;
@property (nonatomic, assign) CGFloat lineWidth;

@end

@implementation GFToastAnnular {
    CALayer *_ringBasicLayer;
    NSTimeInterval _animateDuration;
}

- (void)initializer
{
    CGFloat diameter = MIN(self.width, self.height);
    _ringBasicLayer = [CALayer layer];
    _ringBasicLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    _ringBasicLayer.position = CGPointMake(self.width/2, self.height/2);
    _ringBasicLayer.borderColor = [UIColor whiteColor].CGColor;
    [self addSublayer:_ringBasicLayer];
    
    _lineWidth = 5;
    _animateDuration = 1.5;
    _ringLayer = [CAShapeLayer layer];
    _ringLayer.bounds = CGRectMake(0, 0, diameter, diameter);
    _ringLayer.position = CGPointMake(diameter/2, diameter/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(diameter/2, diameter/2)
                                                        radius:diameter/2-_lineWidth/2
                                                    startAngle:gf_degrees_2_radian(-90)
                                                      endAngle:gf_degrees_2_radian(270)
                                                     clockwise:YES];
    _ringLayer.lineWidth = _lineWidth;
    _ringLayer.path = path.CGPath;
    _ringLayer.lineCap = kCALineCapRound;
    _ringLayer.fillColor = [UIColor clearColor].CGColor;
    _ringLayer.strokeColor = [UIColor redColor].CGColor;
    _ringLayer.strokeEnd = 0;
    _ringLayer.strokeStart = 0;
    _ringBasicLayer.mask = _ringLayer;
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.toValue = @1.0;
    strokeEndAnimation.duration = _animateDuration;
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.toValue = @1.0;
    strokeStartAnimation.duration = _animateDuration*0.5;
    strokeStartAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    strokeStartAnimation.beginTime = _animateDuration;
    strokeStartAnimation.repeatCount = MAXFLOAT;
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.animations = @[strokeEndAnimation, strokeStartAnimation];
    groupAnimation.duration = 1.5*_animateDuration;
    groupAnimation.repeatCount = MAXFLOAT;
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.fromValue = @0.0;
    rotation.toValue = @(2 * M_PI);
    rotation.duration = _animateDuration;
    rotation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotation.repeatCount = MAXFLOAT;
    
    [_ringLayer addAnimation:rotation forKey:nil];
    [_ringLayer addAnimation:groupAnimation forKey:nil];
}

- (void)setAnnularColor:(UIColor *)annularColor
{
    if (![_annularColor isEqual:annularColor])
    {
        _annularColor = annularColor;
        _ringBasicLayer.backgroundColor = annularColor.CGColor;
    }
}

@end

/* ---------------------------toast------------------------------- */

@interface GFToast ()

@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, strong) GFEffectView *contentView;
@property (nonatomic, strong) GFToastBaseLayer *toastLayer;

@end

@implementation GFToast

#pragma mark ---------------------------init-------------------------------

- (instancetype)init
{
    if ([super init])
        [self initializer];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
        [self initializer];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ([super initWithCoder:aDecoder])
        [self initializer];
    return self;
}

- (instancetype)initWithView:(UIView *)view
{
    if ([super init])
    {
        _parentView = view;
        [self initializer];
    }
    return self;
}

- (void)initializer
{
    if (!_parentView)
        _parentView = kCurWindow;
    if (!_contentView) {
        _contentView = [[GFEffectView alloc] init];
        _contentView.backgroundColor = [UIColor blackColor];
        _contentView.layer.cornerRadius = 10.f;
        _contentView.clipsToBounds = YES;
    }
    if (!_label)
    {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:15];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
        [_contentView addSubview:_label];
        [_label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [_label addObserver:self forKeyPath:@"font" options:NSKeyValueObservingOptionNew context:nil];
    }
    _color = [UIColor blackColor];
    [self updateFrames];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"] || [keyPath isEqualToString:@"font"])
        [self updateFrames];
}

- (void)dealloc
{
    [_label removeObserver:self forKeyPath:@"text"];
    [_label removeObserver:self forKeyPath:@"font"];
}

- (void)updateFrames
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        CGFloat height = 20+CGRectGetHeight(_toastLayer.frame);
        CGFloat width = 100;
        CGSize size = [_label.text boundingSizeWithFont:_label.font constrainedToSize:CGSizeMake(2*CGRectGetWidth(_parentView.frame)/3, 0)];
        if (size.height > 0)
            height += 10 + size.height + 20;
        else height += 20;
        width = MAX(size.width+40, width);
        _contentView.bounds = CGRectMake(0, 0, width, height);
        _toastLayer.position = CGPointMake(width/2, 20+CGRectGetHeight(_toastLayer.frame)/2);
        _label.bounds = CGRectMake(0, 0, size.width, size.height);
        _label.center = CGPointMake(width/2, CGRectGetMaxY(_toastLayer.frame)+10+size.height/2);
        _contentView.center = _parentView.center;
    }];
}

- (void)show
{
    [self updateFrames];
    _contentView.center = _parentView.center;
    [_parentView addSubview:_contentView];
    [_parentView bringSubviewToFront:_contentView];
}

- (void)dismiss
{
    
}

#pragma mark ---------------------------setter-------------------------------

- (void)setProgress:(CGFloat)progress
{
    if (_progress != progress)
    {
        if (progress > 1.0) progress = 1.0;
        _progress = progress;
        if (_style == GFToastStyleCake)
        {
            GFToastCake *cake = (GFToastCake *)_toastLayer;
            cake.insideringLayer.strokeEnd = progress;
        }
    }
}

- (void)setStyle:(GFToastStyle)style
{
    switch (style) {
        case GFToastStyleCake:
            _toastLayer = [[GFToastCake alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            [_contentView.layer addSublayer:_toastLayer];
            break;
            
        default:
            break;
    }
}

@end
