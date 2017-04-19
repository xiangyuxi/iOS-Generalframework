//
//  GFNetworkingProtocol.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/18.
//  Copyright © 2017年 xyx. All rights reserved.
//
//  关于session的配置http://www.cnblogs.com/liugengqun/p/5140296.html

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM (NSInteger, GFNetState) {
    /* 无网络连接 */
    GFNetStateUnconnect,
    /* 手机网络 */
    GFNetStateWWAN,
    /* WIFI网络 */
    GFNetStateWIFI,
    /* 未知网络 */
    GFNetStateUnknown
};

typedef NS_ENUM (NSInteger, GFNetworkingMethod) {
    /* POST请求方式 */
    GFNetworkingMethodPOST,
    /* GET请求方式 */
    GFNetworkingMethodGET,
    /* HEAD请求方式 */
    GFNetworkingMethodHEAD,
    /* PUT请求方式 */
    GFNetworkingMethodPUT,
    /* DELETE请求方式 */
    GFNetworkingMethodDELETE,
    /* PATCH请求方式 */
    GFNetworkingMethodPATCH
};

typedef NS_ENUM (NSInteger, GFNetworkingSerializer) {
    GFNetworkingSerializerHTTP,
    GFNetworkingSerializerJSON,
    GFNetworkingSerializerString
};

@protocol GFNetworkingProtocol;

typedef void(^GFNetworkingSuccessBlock)(id<GFNetworkingProtocol> request);
typedef void(^GFNetworkingFailurdBlock)(NSError *error);
typedef void(^GFNetworkingProgressBlock)(CGFloat progress);
typedef void(^GFNetworkingConstructingBodyBlock)(id<AFMultipartFormData> formData);

@protocol GFNetworkingDelegate <NSObject>

@optional
- (void)networkingDidFinish:(id<GFNetworkingProtocol>)request;
- (void)networkingDidFailed:(id<GFNetworkingProtocol>)request error:(NSError *)error;
- (void)networkingProgress:(CGFloat)progress;

@end

@protocol GFNetworkingProtocol <NSObject>

+ (GFNetState)state;

/**
 是否打开Debug模式下的控制台输出开关
 @param flag YES为需要输出，NO为不需要输出
 */
+ (void)openDebugLog:(BOOL)flag;

/**
 请求任务对象
 */
@property (nonatomic, weak) NSURLSessionTask *dataTask;

/**
 服务器地址
 */
@property (nonatomic, copy) NSString *serverAddress;

/**
 请求路径，绝对路径
 */
@property (nonatomic, copy) NSString *absoluteAddress;

/**
 设置请求方式
 */
@property (nonatomic, assign) GFNetworkingMethod method;

/**
 请求参数
 */
@property (nonatomic, copy) NSDictionary *parameters;

/**
 请求响应参数
 */
@property (nonatomic, strong, readonly) id responseObject;

/**
 请求参数格式，默认为JSON
 */
@property (nonatomic, assign) GFNetworkingSerializer requstSerializer;

/**
 在HTTP报头添加的自定义参数
 */
@property (nonatomic, copy) NSDictionary *headerFieldValues;

/**
 代理回调
 */
@property (nonatomic, weak) id<GFNetworkingDelegate> delegate;

/**
 回话配置对象
 */
@property (nonatomic, copy) NSURLSessionConfiguration *sessionConfiguration;

@property (nonatomic, copy, readonly) GFNetworkingFailurdBlock failureBlock;
@property (nonatomic, copy, readonly) GFNetworkingSuccessBlock successBlock;
@property (nonatomic, copy, readonly) GFNetworkingProgressBlock progressBlock;

/**
 POST请求组装body
 */
@property (nonatomic, copy) GFNetworkingConstructingBodyBlock constuctingBodyBlock;

/**
 请求结果反馈方法
 @param responseObject 响应参数
 @param progress 请求进度
 @param error 如果请求失败error不为nil，为nil表示成功
 */
- (void)requestDidResponse:(id)responseObject progress:(CGFloat)progress error:(NSError *)error;

/**
 发送请求
 */
- (void)load;

/**
 取消请求
 */
- (void)cancle;

@end
