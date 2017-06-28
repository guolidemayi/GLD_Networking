//
//  GLD_Service.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/21.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceEnvironment <NSObject>

@optional
- (NSString *)testEnvironmentBaseUrl;
- (NSString *)developEnvironmentBaseUrl;
- (NSString *)releaseEnvironmentBaseUrl;

@end

typedef NS_ENUM(NSInteger, gld_environmentType) {
    gld_environmentTest,
    gld_environmentDevelop,
    gld_environmentRelease,
};

@interface GLD_Service : NSObject<ServiceEnvironment>

+ (instancetype)currentService;

+ (void)switchService;

- (NSString *)baseUrl;

@end



