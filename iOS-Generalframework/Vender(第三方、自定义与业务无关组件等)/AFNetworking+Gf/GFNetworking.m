//
//  GFNetworking.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/18.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFNetworking.h"
#import "GFNetworkingManager.h"

@implementation GFNetworking

@synthesize failureBlock = _failureBlock;
@synthesize successBlock = _successBlock;
@synthesize progressBlock = _progressBlock;


+ (GFNetState)state
{
    if (![AFNetworkReachabilityManager sharedManager].reachable) return GFNetStateUnconnect;
    if ([AFNetworkReachabilityManager sharedManager].reachableViaWWAN) return GFNetStateWWAN;
    if ([AFNetworkReachabilityManager sharedManager].reachableViaWiFi) return GFNetStateWIFI;
    return GFNetStateUnknown;
}

static BOOL debugLog = YES;
+ (void)openDebugLog:(BOOL)flag
{
    debugLog = flag;
}

- (void)loadWithProgress:(GFNetworkingProgressBlock)progress success:(GFNetworkingSuccessBlock)success failed:(GFNetworkingFailurdBlock)failure
{
    _progressBlock = progress;
    _successBlock = success;
    _failureBlock = failure;
    [self load];
}

- (void)requestDidResponse:(id)responseObject progress:(CGFloat)progress error:(NSError *)error
{
    if (error) // 请求失败
    {
        void(^finishBlock)() = ^{
            if (_failureBlock)
                _failureBlock(error);
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingDidFailed:error:)])
                [self.delegate networkingDidFailed:self error:error];
        };
        // 在哪个线程进行回调
        if (_asyncCompleteQueue) finishBlock();
        else dispatch_async(dispatch_get_main_queue(),finishBlock);
        if (debugLog) GFLog(@"%@请求失败：%@",self.absoluteAddress,error);
    }
    else
    {
        void(^finishBlock)() = ^{
            if (responseObject) // 请求已成功
            {
                if (_successBlock)
                    _successBlock(responseObject);
                if (self.delegate && [self.delegate respondsToSelector:@selector(networkingDidFinish:)])
                    [self.delegate networkingDidFinish:responseObject];
                if (debugLog) GFLog(@"%@请求失败：%@",self.absoluteAddress,responseObject);
            }
            else // 请求中，正在下载数据
            {
                if (_progressBlock)
                    _progressBlock(progress);
                if (self.delegate && [self.delegate respondsToSelector:@selector(networkingProgress:)])
                    [self.delegate networkingProgress:progress];
            }
        };
       
        // 在哪个线程进行回调
        if (_asyncCompleteQueue) finishBlock();
        else [[NSOperationQueue mainQueue] addOperationWithBlock:finishBlock];
    }
}

- (void)load
{
    [[GFNetworkingManager sharedGFNetworkingManager] loadRequest:self];
}

- (void)cancle
{
    [_dataTask cancel];
    _progressBlock = nil;
    _constuctingBodyBlock = nil;
    _successBlock = nil;
    _failureBlock = nil;
    _delegate = nil;
}

- (void)dealloc
{
    [self cancle];
}

@end
