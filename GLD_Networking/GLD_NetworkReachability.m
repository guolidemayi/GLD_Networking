//
//  GLD_NetworkReachability.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/27.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "GLD_NetworkReachability.h"
#import "AFNetworkReachabilityManager.h"

@implementation GLD_NetworkReachability


+ (BOOL)isReachable{
    return [AFNetworkReachabilityManager sharedManager].isReachable;
}
@end
