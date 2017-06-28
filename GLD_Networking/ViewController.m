//
//  ViewController.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/21.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "ViewController.h"
#import "GLD_CacheManager.h"


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"%p __ %@",&str ,str);
    str = @"aaa";
    NSLog(@"%p __ %@",&str ,str);
    
    [GLD_CacheManager shareCacheManager];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
