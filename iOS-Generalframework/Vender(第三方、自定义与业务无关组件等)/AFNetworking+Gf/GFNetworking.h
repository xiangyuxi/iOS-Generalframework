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

@property (nonatomic, weak) NSURLSessionTask *dataTask;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, copy) NSString *absoluteAddress;
@property (nonatomic, assign) GFNetworkingMethod method;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, strong, readonly) id responseObject;
@property (nonatomic, assign) GFNetworkingSerializer requstSerializer;
@property (nonatomic, assign) GFNetworkingSerializer resopnseSerializer;
@property (nonatomic, copy) NSDictionary *headerFieldValues;
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) NSURLRequestCachePolicy cachePolicy;
@property (nonatomic, weak) id<GFNetworkingDelegate> delegate;
@property (nonatomic, copy, readonly) GFNetworkingFailurdBlock failureBlock;
@property (nonatomic, copy, readonly) GFNetworkingSuccessBlock successBlock;
@property (nonatomic, copy, readonly) GFNetworkingProgressBlock progressBlock;

- (void)loadWithProgress:(GFNetworkingProgressBlock)progress success:(GFNetworkingSuccessBlock)success failed:(GFNetworkingFailurdBlock)failure;

- (void)load;
- (void)cancle;

@end
