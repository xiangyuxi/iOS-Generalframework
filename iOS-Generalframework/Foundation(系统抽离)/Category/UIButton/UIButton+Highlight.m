//
//  UIButton+Highlight.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "UIButton+Highlight.h"
#import <objc/runtime.h>

#warning 未完成

static const char GfHighlightBackgroundColorAttributeKey = '\0';
static const char GFHighlightBackgroundColorTargetAttributeKey = '\0';

@implementation UIButton (Highlight)

+ (void)load{
    
    // 获取这两个方法
    Method systemMethod = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    SEL sysSEL = @selector(sendAction:to:forEvent:);
    
    Method myMethod = class_getInstanceMethod(self, @selector(gf_sendAction:to:forEvent:));
    SEL mySEL = @selector(gf_sendAction:to:forEvent:);
    
    // 添加方法进去
    BOOL didAddMethod = class_addMethod(self, sysSEL, method_getImplementation(myMethod), method_getTypeEncoding(myMethod));
    
    // 如果方法已经存在了
    if (didAddMethod) {
        class_replaceMethod(self, mySEL, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
    }else{
        method_exchangeImplementations(systemMethod, myMethod);
        
    }
}

- (void)gf_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self gf_sendAction:action to:target forEvent:event];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIButtonBgColorState)state
{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, &GfHighlightBackgroundColorAttributeKey);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, &GfHighlightBackgroundColorAttributeKey, dict, OBJC_ASSOCIATION_RETAIN);
    }
    [dict setValue:backgroundColor forKey:[@(state) stringValue]];
}

@end
