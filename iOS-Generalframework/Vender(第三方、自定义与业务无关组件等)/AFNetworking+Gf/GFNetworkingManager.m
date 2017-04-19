//
//  GFNetworkingManager.m
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/19.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import "GFNetworkingManager.h"

@implementation GFNetworkingManager

gf_singleton_implementation(GFNetworkingManager)

+ (dispatch_queue_t)completeQueue
{
    static dispatch_queue_t completeQueue = NULL;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        completeQueue = dispatch_queue_create("com.GFNetworkingManager.completeQueue", DISPATCH_QUEUE_SERIAL);
        dispatch_set_target_queue(completeQueue, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    });
    return completeQueue;
}

- (void)loadRequest:(id<GFNetworkingProtocol>)request
{
    if (!request) return;
    AFHTTPSessionManager *manager = [self makeAFHTTPSessionManager:request];
    [self configureSessionManager:manager request:request];
    [self sendRequestWithManger:manager request:request];
}

#pragma mark - configure http manager

- (AFHTTPSessionManager *)makeAFHTTPSessionManager:(id<GFNetworkingProtocol>)request
{
    AFHTTPSessionManager *manager = nil;
    if (request.sessionConfiguration) manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:request.serverAddress] sessionConfiguration:request.sessionConfiguration];
    else manager = [AFHTTPSessionManager manager];
    manager.completionQueue = [[self class] completeQueue];
    return manager;
}

- (void)configureSessionManager:(AFHTTPSessionManager *)manager request:(id<GFNetworkingProtocol>)request
{
    if (request.requstSerializer == GFNetworkingSerializerJSON) manager.requestSerializer = [AFJSONRequestSerializer serializer];
    else if (request.requstSerializer == GFNetworkingSerializerString)
    {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    }
    
    NSDictionary *headerFieldValue = request.headerFieldValues;
    if (headerFieldValue) {
        [headerFieldValue enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL * stop) {
            if ([key isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]])
                [manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }];
    }

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
}

- (void)sendRequestWithManger:(AFHTTPSessionManager *)manager request:(id<GFNetworkingProtocol>)request
{
    NSString *URLString = request.absoluteAddress;
    NSDictionary *parameters = request.parameters;
    
    GFNetworkingMethod requestMethod = request.method;
    
    if (requestMethod == GFNetworkingMethodGET)
        request.dataTask = [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            [request requestDidResponse:nil progress:downloadProgress.fractionCompleted error:nil];
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [request requestDidResponse:responseObject progress:0 error:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [request requestDidResponse:nil progress:0 error:error];
        }];
    else if (requestMethod == GFNetworkingMethodPOST)
    {
        GFNetworkingConstructingBodyBlock constructingBodyBlock = request.constuctingBodyBlock;
        if (constructingBodyBlock) {
            request.dataTask =  [manager POST:URLString parameters:parameters constructingBodyWithBlock:constructingBodyBlock progress:^(NSProgress * _Nonnull downloadProgress) {
                [request requestDidResponse:nil progress:downloadProgress.fractionCompleted error:nil];
            } success:^(NSURLSessionDataTask * task, id responseObject) {
                [request requestDidResponse:responseObject progress:0 error:nil];
            } failure:^(NSURLSessionDataTask * task, NSError * error) {
                [request requestDidResponse:nil progress:0 error:error];
            }];
        }else {
            request.dataTask =  [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                [request requestDidResponse:nil progress:downloadProgress.fractionCompleted error:nil];
            } success:^(NSURLSessionDataTask * task, id responseObject) {
                [request requestDidResponse:responseObject progress:0 error:nil];
            } failure:^(NSURLSessionDataTask * task, NSError * error) {
                [request requestDidResponse:nil progress:0 error:error];
            }];
        }
    }
    else if (requestMethod == GFNetworkingMethodHEAD)
    {
        request.dataTask = [manager HEAD:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task) {
            [request requestDidResponse:task progress:0 error:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [request requestDidResponse:nil progress:0 error:error];
        }];
    }
    else if (requestMethod == GFNetworkingMethodPUT)
        request.dataTask = [manager PUT:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
            [request requestDidResponse:task progress:0 error:nil];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [request requestDidResponse:nil progress:0 error:error];
        }];
    else if (requestMethod == GFNetworkingMethodPATCH)
        request.dataTask = [manager PATCH:URLString parameters:parameters success:^(NSURLSessionDataTask * task, id responseObject) {
            [request requestDidResponse:task progress:0 error:nil];
        } failure:^(NSURLSessionDataTask * task, NSError * error) {
            [request requestDidResponse:nil progress:0 error:error];
        }];
    else if (requestMethod == GFNetworkingMethodDELETE)
        request.dataTask = [manager DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [request requestDidResponse:task progress:0 error:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [request requestDidResponse:nil progress:0 error:error];
        }];
}

@end
