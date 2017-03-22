//
//  HJAlertAction.m
//  HJAlertViewDemo
//
//  Created by HJ on 2016/10/18.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "HJAlertAction.h"
#import "MBProgressHUD.h"

@implementation HJAlertAction



+(void)showMessage:(NSString *)message withSuperView:(UIView *)superView withMessageMode:(HJAlertViewMode)mode
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.numberOfLines = 0;
    hud.minSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.8, 0);
    hud.margin = 15;
    hud.bezelView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    hud.label.textColor = [UIColor whiteColor];
    hud.label.text = NSLocalizedString(message, @"HUD message title");
    [hud showAnimated:YES];
    switch (mode) {
        case HJAlertViewModeTop:
        {
            hud.offset = CGPointMake(0.f, -[UIScreen mainScreen].bounds.size.height/2 + 100);
        }
            break;
        case HJAlertViewModeMiddle:
        {
            hud.offset = CGPointMake(0.f, 0.f);
        }
            break;
        case HJAlertViewModeBottom:
        {
            hud.offset = CGPointMake(0.f, [UIScreen mainScreen].bounds.size.height/2 - 100);
        }
            break;
            
        default:
            break;
    }
    
    
    [hud hideAnimated:YES afterDelay:1.5f];
}


+(void)addAlertTitle:(NSString *)titleString message:(NSString *)messageString withCancelButton:(NSString *)cancelTitle confirmButton:(NSString *)confirmTitle withClickConfirmBlock:(void (^)())confirm withCancelBlock:(void (^)())cancelBlock
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleString message:messageString preferredStyle:UIAlertControllerStyleAlert];
    
    if (confirmTitle != nil) {
        [alert addAction:[UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            confirm();
            
        }]];
    }
    
    
    [alert addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        cancelBlock();
    }]];
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
