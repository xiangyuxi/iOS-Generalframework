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
#import "GFModel.h"

@interface Model2 : GFModel

@property (nonatomic, copy) NSString *msg;

@end
@implementation Model2
@end

@interface Model1 : GFModel

@property (nonatomic, assign) int code;
@property (nonatomic, assign) float success;

@property (nonatomic, assign) NSInteger code1;
@property (nonatomic, assign) CGFloat success1;

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, copy) NSArray<Model2 *> *array;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, copy) NSDictionary *dictionary;
@property (nonatomic, strong) Model2 *model2;
@property (nonatomic, strong) id haha;

@end
@implementation Model1
@end

@interface ViewController () {
    dispatch_source_t timer;
}

@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [Model1 modelFromDictionary:@{}];
    [super viewDidLoad];
    [self.btn setBackgroundColor:[UIColor redColor] forState:GFButtonStateHighlight];
    self.btn.itStyle = GFButtonITStyleTop;
    GFLog(@"%@   %@",[GFDeviceUtil sharedGFDeviceUtil],[GFDeviceUtil sharedGFDeviceUtil].deviceModel);
    
}
- (IBAction)btnAction:(id)sender
{
}

@end
