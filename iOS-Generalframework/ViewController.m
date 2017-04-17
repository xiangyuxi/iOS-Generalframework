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

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn setBackgroundColor:[UIColor redColor] forState:GFButtonStateHighlight];
    
    GFLog(@"%@   %@",[GFDeviceUtil sharedGFDeviceUtil],[GFDeviceUtil sharedGFDeviceUtil].deviceModel);
    
}
- (IBAction)btnAction:(id)sender {
    NSLog(@"btnAction");
}

@end
