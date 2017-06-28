//
//  GLD_NetworkClient.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "GLD_NetworkClient.h"
#import "AFNetworking.h"
#import "GLD_Request.h"
#import "GLD_NetworkReachability.h"

@interface GLD_NetworkClient ()

@property(nonatomic, strong)AFHTTPSessionManager *sessionManager;
@property(nonatomic, strong)NSMutableDictionary<NSNumber *, NSURLSessionTask *> *dispathTable;
@property(nonatomic, assign)NSInteger totalTaskCount;
@property(nonatomic, assign)NSInteger errorTaskCount;
@end
@implementation GLD_NetworkClient

static GLD_NetworkClient *shareNetworkClient;
static dispatch_semaphore_t lock;


+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareNetworkClient = [[GLD_NetworkClient alloc]init];
        lock = dispatch_semaphore_create(1);
    });
    return shareNetworkClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dispathTable = [NSMutableDictionary dictionaryWithCapacity:0];
        self.totalTaskCount = self.errorTaskCount = 0;
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

        
    }
    return self;
}

- (NSURLSessionDataTask *)dataTaskWithPath:(NSString *)path useHttps:(BOOL)useHttps requestType:(gld_networkRequestType)requestType params:(NSDictionary *)params headers:(NSDictionary *)headers completionHandle:(void(^)(NSURLResponse *, id, NSError *))completionHandle{
    
    NSString *method = requestType == gld_networkRequestTypeGET ? @"GET" : @"POST";
    NSMutableArray *taskIdentifier = [NSMutableArray arrayWithObject:@-1];
    
    NSMutableURLRequest *request = [[GLD_Request shareInstance] generateRequestWithPath:path useHttps:useHttps method:method params:params headers:headers];
    
    NSURLSessionDataTask *task = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
        [self checkSeriveWithTaskError:error];
        [self.dispathTable removeObjectForKey:taskIdentifier.firstObject];
        dispatch_semaphore_signal(lock);
        completionHandle ? completionHandle(response,responseObject, error) : nil;
        
    }];
    taskIdentifier[0] = @(task.taskIdentifier);
    return task;
}

- (NSNumber *)dispatchTask:(NSURLSessionDataTask *)task{
    if (task == nil) return @-1;
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    self.totalTaskCount += 1;
    [self.dispathTable setObject:task forKey:@(task.taskIdentifier)];
    dispatch_semaphore_signal(lock);
    [task resume];
    return @(task.taskIdentifier);
}

- (NSNumber *)dispatchTaskWithPath:(NSString *)path useHttps:(BOOL)useHttps requestType:(gld_networkRequestType)requestType params:(NSDictionary *)params headers:(NSDictionary *)headers completionHandle:(void(^)(NSURLResponse *, id, NSError *))completionHandle{

    return [self dispatchTask:[self dataTaskWithPath:path useHttps:useHttps requestType:requestType params:params headers:headers completionHandle:completionHandle]];
}


+ (void)cancleTaskWithTaskIdentifier:(NSNumber *)taskIdentifier{
    [shareNetworkClient cancleTaskWithTaskIdentifier:taskIdentifier];
}

- (void)cancleTaskWithTaskIdentifier:(NSNumber *)taskIdentifier{
    [self.dispathTable[taskIdentifier] cancel];
    dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
    [self.dispathTable removeObjectForKey:taskIdentifier];
    dispatch_semaphore_signal(lock);
}

- (void)checkSeriveWithTaskError:(NSError *)error{
    if ([GLD_NetworkReachability isReachable]) {
    
        
        switch (error.code) {
            case NSURLErrorUnknown:
            case NSURLErrorTimedOut:
            case NSURLErrorCannotConnectToHost: {
                self.errorTaskCount += 1;
            }
                
            default:
                break;
        }
        if(self.totalTaskCount >= 30 && ((CGFloat)self.errorTaskCount / self.totalTaskCount) >= 0.1){
            self.totalTaskCount = self.errorTaskCount = 0;
            [GLD_Request switchService];
        }
        
    }
}

@end
