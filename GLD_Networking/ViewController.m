//
//  ViewController.m
//  GLD_Networking
//
//  Created by yiyangkeji on 2017/6/21.
//  Copyright © 2017年 yiyangkeji. All rights reserved.
//

#import "ViewController.h"
#import "GLD_CacheManager.h"
#import "GLD_DataApiManager.h"

@interface ViewController ()

@property (nonatomic, strong)GLD_DataApiManager *dataManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSLog(@"%p __ %@",&str ,str);
    
    
    [self configuration];
    [self fetch];
}


- (void)configuration{
    self.dataManager = [GLD_DataApiManager new];
}

- (void)fetch{
    [self.dataManager fetchDataWithCompletionHandle:^(NSError *error, id result) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
