//
//  GLD_DataApiManager.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/28.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "GLD_DataApiManager.h"

@interface GLD_DataApiManager ()
{
    NSInteger  _currentPage;
}

@end

@implementation GLD_DataApiManager


- (NSNumber *)fetchDataWithCompletionHandle:(completionHandleBlock)completionHandler{
    _currentPage = 1;
    return [self dispatchTaskWithCompletionHandler:completionHandler];
}

- (NSNumber *)loadMoreDataWithCompletionHandle:(completionHandleBlock)completionHandler{
    _currentPage ++;
    return [self dispatchTaskWithCompletionHandler:completionHandler];
}
- (NSNumber *)dispatchTaskWithCompletionHandler:(completionHandleBlock)completionHandler{
    GLD_APIConfiguration *config = [GLD_APIConfiguration new];
    config.urlPath = @"";
    config.requestType = gld_networkRequestTypeGET;
    config.requestParameters = @{};
    return [super dispatchDataTaskWith:config andCompletionHandler:^(NSError *error, id result) {
        
        if (!error) {
            //数据处理
        }
        completionHandler?completionHandler(error, result):nil;
        
    }];
    
}

@end
