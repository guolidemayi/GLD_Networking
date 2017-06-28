//
//  GLD_CacheManager.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "GLD_CacheManager.h"


@interface GLD_Cache ()

@property (nonatomic, assign)NSUInteger cacheTime; //缓存存入时间
@property (nonatomic, assign)NSUInteger validTime; //缓存有效时间
@property(nonatomic, strong)id data;

@end

#define ValidTimeInterval 60 //秒
@implementation GLD_Cache

+(instancetype)cacheWithData:(id)data validTime:(NSUInteger)validTime{
    GLD_Cache *cache = [GLD_Cache new];
    cache.cacheTime = [[NSDate date] timeIntervalSince1970];
    cache.validTime = validTime > 0 ? validTime : ValidTimeInterval;
    return cache;
}
-(BOOL)isValid{
    if (self.data) {
        return [[NSDate date] timeIntervalSince1970] - self.cacheTime < self.validTime;
    }
    return NO;
}

@end

@interface GLD_CacheManager ()

@property(nonatomic, strong)NSCache *cache;

@end
@implementation GLD_CacheManager



+ (instancetype)shareCacheManager{
    static GLD_CacheManager *shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[GLD_CacheManager alloc]init];
        [shareManager configuration];
    });
    NSLog(@"cache = %p -- %@",&str, str);
    return shareManager;
}
- (void)configuration{
    self.cache = [NSCache new];
    self.cache.totalCostLimit = 1024 * 1024 * 20; //20 兆
}


- (void)setObjcet:(GLD_Cache *)object key:(id)key{
    [self.cache setObject:object forKey:key];
}

- (void)removeObjectForKey:(id)key{
    [self.cache removeObjectForKey:key];
}
- (GLD_Cache *)objectForKey:(id)key{
    return [self.cache objectForKey:key];
}
@end
