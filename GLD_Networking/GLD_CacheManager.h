//
//  GLD_CacheManager.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLD_Cache : NSObject

-(BOOL)isValid;
- (id)data;

+(instancetype)cacheWithData:(id)data validTime:(NSUInteger)validTime;
@end

static NSString *str;
@interface GLD_CacheManager : NSObject
+ (instancetype)shareCacheManager;
- (void)setObjcet:(GLD_Cache *)object key:(id)key;
- (void)removeObjectForKey:(id)key;
- (GLD_Cache *)objectForKey:(id)key;
@end
