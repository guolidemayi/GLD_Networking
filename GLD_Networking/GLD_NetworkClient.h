//
//  GLD_NetworkClient.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLD_NetworkConfig.h"


@interface GLD_NetworkClient : NSObject


- (NSNumber *)dispatchTaskWithPath:(NSString *)path useHttps:(BOOL)useHttps requestType:(gld_networkRequestType)requestType params:(NSDictionary *)params headers:(NSDictionary *)headers completionHandle:(void(^)(NSURLResponse *, id, NSError *))completionHandle;

+ (instancetype)shareInstance;

+ (void)cancleTaskWithTaskIdentifier:(NSNumber *)taskIdentifier;
@end
