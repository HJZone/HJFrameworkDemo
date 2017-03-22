//
//  HJAlertAction.h
//  HJAlertViewDemo
//
//  Created by HJ on 2016/10/18.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HJAlertViewMode) {
    HJAlertViewModeTop,// 屏幕顶部显示
    HJAlertViewModeMiddle,// 屏幕中间显示
    HJAlertViewModeBottom,//屏幕底部显示
};


//cell代理方法
@protocol HJAlertViewDelegate <NSObject>
@optional

- (void)hjAlertView:(nullable UIView *)alertView didClickButtonAtIndex:(NSUInteger)index;

@end

@interface HJAlertAction : UIView


/**
 显示提示信息

 @param message   提示内容
 @param superView 父视图
 @param mode      提示框显示模式，顶部/中间/底部
 */
+(void)showMessage:(nullable NSString *)message withSuperView:(nullable UIView *)superView withMessageMode:(HJAlertViewMode)mode;



+(void)addAlertTitle:(nullable NSString *)titleString message:(nullable NSString *)messageString withCancelButton:(nullable NSString *)cancelTitle confirmButton:(nullable NSString *)confirmTitle withClickConfirmBlock:(void (^__nullable)())confirm withCancelBlock:(void (^__nullable)())cancelBlock;

@end
