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

@interface ViewController () {
    dispatch_source_t timer;
}

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.btn setBackgroundColor:[UIColor redColor] forState:GFButtonStateHighlight];
    self.btn.itStyle = GFButtonITStyleTop;
    GFLog(@"%@   %@",[GFDeviceUtil sharedGFDeviceUtil],[GFDeviceUtil sharedGFDeviceUtil].deviceModel);
    
}
- (IBAction)btnAction:(id)sender
{
}

@end
