//
//  GFNetworking.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/18.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GFNetworkingProtocol.h"

@interface GFNetworking : NSObject <GFNetworkingProtocol>

+ (GFNetState)state;
+ (void)openDebugLog:(BOOL)flag;

@property (nonatomic, weak) NSURLSessionTask *                  dataTask;
@property (nonatomic, copy) NSString *                          serverAddress;
@property (nonatomic, copy) NSString *                          absoluteAddress;
@property (nonatomic, assign) GFNetworkingMethod                method;
@property (nonatomic, copy) NSDictionary *                      parameters;
@property (nonatomic, strong, readonly) id                      responseObject;
@property (nonatomic, assign) GFNetworkingSerializer            requstSerializer;
@property (nonatomic, copy) NSDictionary *                      headerFieldValues;
@property (nonatomic, weak) id<GFNetworkingDelegate>            delegate;
@property (nonatomic, copy) NSURLSessionConfiguration *         sessionConfiguration;
@property (nonatomic, copy, readonly) GFNetworkingFailurdBlock  failureBlock;
@property (nonatomic, copy, readonly) GFNetworkingSuccessBlock  successBlock;
@property (nonatomic, copy, readonly) GFNetworkingProgressBlock progressBlock;
@property (nonatomic, copy) GFNetworkingConstructingBodyBlock   constuctingBodyBlock;

/**
 是否在异步线程中完成回调，默认为NO，在主线程中回调
 */
@property (nonatomic, assign) BOOL asyncCompleteQueue;

- (void)loadWithProgress:(GFNetworkingProgressBlock)progress success:(GFNetworkingSuccessBlock)success failed:(GFNetworkingFailurdBlock)failure;

- (void)load;
- (void)cancle;

@end
