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
#import "GFToast.h"

@interface ViewController () {
    dispatch_source_t timer;
}

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.btn setBackgroundColor:[UIColor redColor] forState:GFButtonStateHighlight];
    CALayer
    GFLog(@"%@   %@",[GFDeviceUtil sharedGFDeviceUtil],[GFDeviceUtil sharedGFDeviceUtil].deviceModel);
    
}
- (IBAction)btnAction:(id)sender {
    
    GFToast *toast = [[GFToast alloc] init];
    toast.style = GFToastStyleCake;
    [toast show];
    
    __block CGFloat progress = 0;
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC, 1 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        progress += (1.0/50.0);
        toast.progress = progress;
        toast.label.text = [NSString stringWithFormat:@"已完成%.0f%@",progress*100,@"%"];
        if (progress > 1)
            dispatch_cancel(timer);
    });
    dispatch_resume(timer);
    
}

@end
