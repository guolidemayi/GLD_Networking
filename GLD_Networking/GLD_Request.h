//
//  GLD_Request.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLD_Request : NSObject

+ (instancetype)shareInstance;
+ (void)switchService;
- (NSMutableURLRequest *)generateRequestWithPath:(NSString *)path
                                        useHttps:(BOOL)useHttps
                                          method:(NSString *)method
                                          params:(NSDictionary *)params
                                         headers:(NSDictionary *)headers;

- (NSMutableURLRequest *)generateUploadRequestWithPath:(NSString *)path
                                              useHttps:(BOOL)useHttps
                                                method:(NSString *)method
                                                params:(NSDictionary *)params
                                               headers:(NSDictionary *)headers
                                              contents:(NSArray<NSData *> *)contents;
@end
