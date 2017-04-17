//
//  UIButton+Highlight.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIButton+Highlight.h"
#import <objc/runtime.h>

static const char GfHighlightBackgroundColorAttributeKey = '\0';

/*
static UIControlState gfstate_2_uistate(GFButtonState state)
{
    if (state == GFButtonStateNormal) return UIControlStateNormal;
    else if (state == GFButtonStateSelected) return UIControlStateSelected;
    else return UIControlStateHighlighted;
}
*/

@implementation UIButton (Highlight)

+ (void)load
{
    Method originalM = class_getInstanceMethod([self class], @selector(setSelected:));
    Method exchangeM = class_getInstanceMethod([self class], @selector(gf_setSelected:));
    method_exchangeImplementations(originalM, exchangeM);
}

- (void)gf_setSelected:(BOOL)selected
{
    UIColor *aColor = [self backgroundColorForState:selected?GFButtonStateSelected:GFButtonStateNormal];
    if (aColor) super.backgroundColor = aColor;
    [self gf_setSelected:selected];
}

- (void)gf_touchDown:(UIButton *)btn
{
    UIColor *aColor = [self backgroundColorForState:GFButtonStateHighlight];
    if (aColor) super.backgroundColor = aColor;
}

- (void)gf_touchCancelHighlighted:(UIButton *)btn
{
    UIColor *aColor = [self backgroundColorForState:GFButtonStateNormal];
    if (aColor) super.backgroundColor = aColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(GFButtonState)state
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &GfHighlightBackgroundColorAttributeKey);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        [dict setValue:[UIColor clearColor] forKey:[@(GFButtonStateNormal) stringValue]];// 设置默认透明色
        objc_setAssociatedObject(self, &GfHighlightBackgroundColorAttributeKey, dict, OBJC_ASSOCIATION_RETAIN);
        // 确保只有一次
        [self addTarget:self action:@selector(gf_touchDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(gf_touchCancelHighlighted:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchDragOutside | UIControlEventTouchCancel];
    }
    [dict setValue:backgroundColor forKey:[@(state) stringValue]];
}

- (UIColor *)backgroundColorForState:(GFButtonState)state
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &GfHighlightBackgroundColorAttributeKey);
    return dict[[@(state) stringValue]];
}

@end
