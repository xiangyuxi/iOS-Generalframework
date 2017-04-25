//
//  ViewController.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/16.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Highlight.h"
#import "GFDeviceUtil.h"
#import "UIButton+Gf.h"
#import "UIViewController+Gf.h"
#import "UITextField+Gf.h"

@interface ViewController () {
    dispatch_source_t timer;
}

@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) UIViewController *controller;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn setBackgroundColor:[UIColor redColor] forState:GFButtonStateHighlight];
    self.btn.itStyle = GFButtonITStyleTop;
    GFLog(@"%@   %@",[GFDeviceUtil sharedGFDeviceUtil],[GFDeviceUtil sharedGFDeviceUtil].deviceModel);
    
//    self.controller = [[UIViewController alloc] init];
//    
//    [self.controller setViewDidLoadBlock:^(UIViewController *controller) {
//        GFLog(@"ViewDidLoadBlock");
//    }];
//    
//    self.controller.view.frame = CGRectMake(0, 0, 100, 100);
//    
//    self.controller.view.backgroundColor = [UIColor redColor];
//    
//    [self.view addSubview:self.controller.view];
//    [self.controller willMoveToParentViewController:self];
//    [self addChildViewController:self.controller];
//    [self.controller didMoveToParentViewController:self];
//    
//    [self.controller setViewWillAppearBlock:^(UIViewController *controller, BOOL aAnimated) {
//        GFLog(@"ViewWillAppearBlock");
//    }];
//    [self.controller setViewDidAppearBlock:^(UIViewController *controller, BOOL aAnimated) {
//        GFLog(@"ViewDidAppearBlock");
//    }];
//    [self.controller setViewWillDisappearBlock:^(UIViewController *controller, BOOL aAnimated) {
//        GFLog(@"ViewWillDisappearBlock");
//    }];
//    [self.controller setViewDidDisappearBlock:^(UIViewController *controller, BOOL aAnimated) {
//        GFLog(@"ViewDidDisappearBlock");
//    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.textField resignFirstResponder];
}
- (IBAction)btnAction:(id)sender
{
    self.textField.secureTextEntry = !self.textField.secureTextEntry;
}

@end
