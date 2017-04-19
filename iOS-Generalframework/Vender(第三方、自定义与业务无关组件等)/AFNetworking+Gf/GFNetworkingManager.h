//
//  GFNetworkingManager.h
//  iOS-Generalframework
//
//  Created by yxiang on 2017/4/19.
//  Copyright © 2017年 xyx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GF_Macros.h"
#import "GFNetworking.h"

@interface GFNetworkingManager : NSObject

gf_singleton_interface(GFNetworkingManager)

- (void)loadRequest:(id<GFNetworkingProtocol>)request;

@end
