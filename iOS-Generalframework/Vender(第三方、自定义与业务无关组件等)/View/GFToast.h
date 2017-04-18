//
//  GFToast.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/17.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

#warning 在动态改变label的文字时出现闪的情况，暂时还没有解决办法

typedef NS_ENUM(NSInteger, GFToastStyle) {
    /// 可以设置progress控制进度
    /* 圆饼图 */
    GFToastStyleCake,
    /* 水平进度条 */
    GFToastStyleHorizontalBar,
    
    /// 网络加载动画
    /* 圆环 */
    GFToastStyleAnnular,
    /* 系统自带的指示器 */
    GFToastStyleIndicator,
    
    /* 只显示文字 */
    GFToastStyleText
};

@interface GFToast : UIView

- (instancetype)initWithView:(UIView *)view;
- (void)show;
- (void)dismiss;
/**
 只有在GFToastStyleCake和GFToastStyleHorizontalBar两种情况下才有效，0到1有效
 */
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy, readonly) UILabel *label;
@property (nonatomic, copy) UIColor *color;
@property (nonatomic, assign) BOOL needMask;
/**
 默认为GFToastStyleCake
 */
@property (nonatomic, assign) GFToastStyle style;

@end
