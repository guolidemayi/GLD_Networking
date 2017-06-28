//
//  GLD_NetworkAPIManager.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import "GLD_NetworkAPIManager.h"
#import "GLD_CacheManager.h"
#import "GLD_NetworkClient.h"
#import "GLD_NetworkError.h"

@implementation GLD_NetworkAPIManager


+ (void)cancelTaskWith:(NSNumber *)taskIdentifier{
    [GLD_NetworkClient cancleTaskWithTaskIdentifier:taskIdentifier];
}

- (NSNumber *)dispatchDataTaskWith:(GLD_APIConfiguration *)config andCompletionHandler:(completionHandleBlock)completionHandle{
    NSString *cacheKey;
    if(config.cacheValidTimeInterval > 0){
        
        cacheKey = [self md5WithString:config.urlPath];
        
        GLD_Cache *cache = [[GLD_CacheManager shareCacheManager] objectForKey:cacheKey];
        if (cache.isValid) {
            completionHandle ? completionHandle(cache.data,nil) : nil;
            return @-1;
        }else{
            [[GLD_CacheManager shareCacheManager] removeObjectForKey:cacheKey];
        }
        
    }
    NSNumber *taskIdentifier = [[GLD_NetworkClient shareInstance] dispatchTaskWithPath:config.urlPath useHttps:config.useHttps requestType:config.requestType params:config.requestParameters headers:config.requestHeader completionHandle:^(NSURLResponse * response, id data, NSError *error) {
        
        if (!error && config.cacheValidTimeInterval > 0) {
            GLD_Cache *cacheData = [GLD_Cache cacheWithData:data validTime:config.cacheValidTimeInterval];
            [[GLD_CacheManager shareCacheManager] setValue:cacheData forKey:cacheKey];
        }
        
        completionHandle ? completionHandle(data, [self formatError:error]):nil;
    }];
    
    return taskIdentifier;
    
}


- (NSError *)formatError:(NSError *)error{
    
    switch (error.code) {
        case NSURLErrorCancelled:
            error = gld_Error(gld_CanceledErrorNotice, gld_NetworkTaskErrorCanceled);
            break;
            
        case NSURLErrorTimedOut: error = gld_Error(gld_TimeoutErrorNotice, gld_NetworkTaskErrorTimeOut);
            break;
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNotConnectedToInternet: error = gld_Error(gld_NetworkErrorNotice, gld_NetworkTaskErrorCannotConnectedToInternet);
            break;
            
        default: {
            error = gld_Error(gld_DefaultErrorNotice, gld_NetworkTaskErrorDefault);
        }   break;
    }
    
    return error;
}

- (NSString *)md5WithString:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    //    CC_MD5( cStr, strlen(cStr), result );
    return [[[NSString alloc] initWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

@end
