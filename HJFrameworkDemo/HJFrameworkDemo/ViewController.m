//
//  ViewController.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "ViewController.h"
#import "HJTabBarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    
    window.rootViewController = [[HJTabBarController alloc] init];
    
    
    NSLog(@"sdadsada");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
