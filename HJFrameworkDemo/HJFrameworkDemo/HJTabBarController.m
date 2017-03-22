//
//  HJTabBarController.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "HJTabBarController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "ForthViewController.h"

@implementation HJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViewControllers];
    
}


/**
 设置子视图控制器
 */
-(void)setUpViewControllers
{
    //首页
    UINavigationController *homeNav = [self creatNavigationControllerWithViewController:[[FirstViewController alloc] init] andNavigationTitle:@"首页" andTabBarTitle:@"首页" andPreImage:[UIImage imageNamed:@"tab_home_pre"] andSelectImage:[UIImage imageNamed:@"tab_home"]];
    
    //社区
    UINavigationController *communityNav = [self creatNavigationControllerWithViewController:[[SecondViewController alloc] init] andNavigationTitle:@"社区" andTabBarTitle:@"社区" andPreImage:[UIImage imageNamed:@"tab_community_pre"] andSelectImage:[UIImage imageNamed:@"tab_community"]];
    
    //数据库
    UINavigationController *shortcutNav = [self creatNavigationControllerWithViewController:[[ThirdViewController alloc] init] andNavigationTitle:@"数据库" andTabBarTitle:@"数据库" andPreImage:[UIImage imageNamed:@"tab_shield_pre"] andSelectImage:[UIImage imageNamed:@"tab_shield"]];
    
    //我的
    UINavigationController *keyNav = [self creatNavigationControllerWithViewController:[[ForthViewController alloc] init] andNavigationTitle:@"我的" andTabBarTitle:@"我的" andPreImage:[UIImage imageNamed:@"tab_lock_pre"] andSelectImage:[UIImage imageNamed:@"tab_lock"]];
    
    
    
    
    
    self.viewControllers = @[homeNav,communityNav,shortcutNav,keyNav];
    
    
}


/**
 创建导航视图
 
 @param viewController        view controller
 @param navigationTitleString 导航栏标题
 @param tabBarTitleString     table bar 标题
 @param preImage              常态图片
 @param selectImage           选择时图片
 
 @return 导航视图控制器
 */
-(UINavigationController *)creatNavigationControllerWithViewController:(UIViewController *)viewController andNavigationTitle:(NSString *)navigationTitleString andTabBarTitle:(NSString *)tabBarTitleString andPreImage:(UIImage *)preImage andSelectImage:(UIImage *)selectImage
{
    //设置背景色
    viewController.view.backgroundColor = [UIColor whiteColor];
    //设置导航栏标题
    viewController.navigationItem.title = navigationTitleString;
    
    //初始化导航视图控制器
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    //设置tabBar常态图片
    [navigationController.tabBarItem setImage:[preImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置tabBar选择时图片
    [navigationController.tabBarItem setSelectedImage:[selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    //设置tabBar标题
    navigationController.tabBarItem.title = tabBarTitleString;
    //navigationController.navigationBar.barTintColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1];
    [navigationController.navigationBar setBackgroundImage:[self creatImageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    
    
    //设置tabBar常态字体颜色
    [navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    //设置tabBar选择时字体颜色
    [navigationController.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1],NSForegroundColorAttributeName, nil] forState:UIControlStateHighlighted];
    
    return navigationController;
}


//根据颜色生成图片
-(UIImage *)creatImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
