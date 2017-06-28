//
//  GLD_NetworkError.h
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/28.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#ifndef GLD_NetworkError_h
#define GLD_NetworkError_h
typedef enum : NSUInteger {
    gld_NetworkTaskErrorTimeOut = 101,
    gld_NetworkTaskErrorCannotConnectedToInternet = 102,
    gld_NetworkTaskErrorCanceled = 103,
    gld_NetworkTaskErrorDefault = 104,
    gld_NetworkTaskErrorNoData = 105,
    gld_NetworkTaskErrorNoMoreData = 106
} gld_NetworkTaskError;

static NSError *gld_Error(NSString *domain, int code) {
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}

static NSString *gld_NoDataErrorNotice = @"这里什么也没有~";
static NSString *gld_NetworkErrorNotice = @"请检查网络设置~";
static NSString *gld_TimeoutErrorNotice = @"请求超时了~";
static NSString *gld_DefaultErrorNotice = @"请求失败了~";
static NSString *gld_NoMoreDataErrorNotice = @"没有更多了~";
static NSString *gld_CanceledErrorNotice = @"请求被取消了~";

#endif /* GLD_NetworkError_h */
