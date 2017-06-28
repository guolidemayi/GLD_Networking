//
//  GLD_Service.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/21.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "GLD_Service.h"

typedef NS_ENUM(NSInteger, gld_serviceType) {
    gldService0,
    gldService1
    
};

@interface GLD_Service ()

@property (nonatomic, assign)gld_environmentType environment;
@property (nonatomic, assign)NSInteger type;
@end
@interface GLD_Service0 : GLD_Service
@end

@interface GLD_Service1 : GLD_Service
@end
@implementation GLD_Service

static  GLD_Service *currentSerVice;
static  dispatch_semaphore_t serviceLock;//创建lock，保证切换服务器线程安全
+ (instancetype)currentService{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentSerVice = [GLD_Service new];
        serviceLock = dispatch_semaphore_create(1);
        
    });
    return currentSerVice;
}

+ (void)switchService{
    [GLD_Service switchToService:currentSerVice.type + 1];
}

+ (void)switchToService:(gld_environmentType)serviceType{
    dispatch_semaphore_wait(serviceLock, DISPATCH_TIME_FOREVER);
    currentSerVice = [GLD_Service serviceWithType:serviceType % 3];
    dispatch_semaphore_signal(serviceLock);
}

+ (GLD_Service *)serviceWithType:(gld_serviceType)type{
    GLD_Service *service;
    switch (type) {
        case gldService0:
            service = [[GLD_Service0 alloc]init];
            break;
        case gldService1:
            service = [[GLD_Service1 alloc]init];
            break;
    }
    service.type = type;
    service.environment = gld_environmentRelease;
    return service;
}
- (NSString *)baseUrl{
    switch (self.environment) {
        case gld_environmentTest:
            return [self testEnvironmentBaseUrl];
            break;
        case gld_environmentDevelop:
            return [self developEnvironmentBaseUrl];
            break;
        case gld_environmentRelease:
            return [self releaseEnvironmentBaseUrl];
            break;
        
    }
}
@end


@implementation GLD_Service0

- (NSString *)testEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}

- (NSString *)developEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}

- (NSString *)releaseEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}
@end
@implementation GLD_Service1

- (NSString *)testEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}

- (NSString *)developEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}

- (NSString *)releaseEnvironmentBaseUrl {
    return @"http://api.1shuo.com/";
}
@end
