//
//  UIButton+Highlight.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIButtonBgColorState) {
    UIButtonBgColorStateNormal,
    UIButtonBgColorStateHighlight,
    UIButtonBgColorStateSelected
};

@interface UIButton (Highlight)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIButtonBgColorState)state;

@end
