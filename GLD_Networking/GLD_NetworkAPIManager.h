//
//  GLD_NetworkAPIManager.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLD_NetworkConfig.h"


typedef void(^completionHandleBlock)(NSError *, id);

@interface GLD_APIConfiguration : NSObject


@property (copy, nonatomic) NSString *urlPath;
@property (strong, nonatomic) NSDictionary *requestParameters;

@property (assign, nonatomic) BOOL useHttps;
@property (strong, nonatomic) NSDictionary *requestHeader;
@property (assign, nonatomic) gld_networkRequestType requestType;

@property (assign, nonatomic) NSTimeInterval cacheValidTimeInterval;
@end

@interface GLD_NetworkAPIManager : NSObject


+ (void)cancelTaskWith:(NSNumber *)taskIdentifier;

- (NSNumber *)dispatchDataTaskWith:(GLD_APIConfiguration *)config andCompletionHandler:(completionHandleBlock)completionHandle;
@end
