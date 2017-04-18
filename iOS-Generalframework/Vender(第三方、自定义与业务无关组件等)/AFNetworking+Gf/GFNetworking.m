//
//  GFNetworking.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/18.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFNetworking.h"

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

+ (void)openDebugLog:(BOOL)flag
{
    
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
    if (error)
    {
        if (_failureBlock)
            _failureBlock(error);
        if (self.delegate && [self.delegate respondsToSelector:@selector(networkingDidFailed:error:)])
            [self.delegate networkingDidFailed:self error:error];
    }
    else
    {
        if (responseObject)
        {
            if (_successBlock)
                _successBlock(responseObject);
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingDidFinish:)])
                [self.delegate networkingDidFinish:responseObject];
        }
        else
        {
            if (_progressBlock)
                _progressBlock(progress);
            if (self.delegate && [self.delegate respondsToSelector:@selector(networkingProgress:)])
                [self.delegate networkingProgress:progress];
        }
    }
}

- (void)load
{
    
}

- (void)cancle
{
    [_dataTask cancel];
    _progressBlock = nil;
    _successBlock = nil;
    _failureBlock = nil;
    _delegate = nil;
}

@end
