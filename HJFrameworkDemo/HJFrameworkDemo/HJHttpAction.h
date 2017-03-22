//
//  HJHttpAction.h
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJHttpAction : NSObject

/**
 获取短信验证码
 
 @param phoneNumber   用户手机号
 @param isForRegister YES : 注册页面， NO ：找回密码页面
 @param completion    获取短信验证码成功时调用此代码块
 @param errorBlock    获取验证码失败时调用，并返回错误信息
 */
+(void)requestForGetPhoneCodeWithPhoneNumerString:(NSString *)phoneNumber isForRegister:(BOOL)isForRegister withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;


/**
 注册SDK
 
 @param phoneNumber 用户手机号码
 @param phoneCode 短信验证码
 @param completion 注册完成时调用
 @param errorBlock 注册失败时调用，并返回异常信息
 */
+(void)requestFor_SDK_RegieterWithPhoneNumber:(NSString *)phoneNumber phoneCode:(NSString *)phoneCode withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;



/**
 完成APP注册
 
 @param phoneNumber 用户手机号
 @param password 密码
 @param completion 注册完成时调用
 @param errorBlock 注册失败时调用，并返回错误信息
 */
+(void)requestFor_APP_RegisterWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;


/**
 重置密码
 
 @param phoneNumber 用户手机号
 @param phoneCode   短信验证码
 @param password    密码
 @param completion  获取短信验证码成功时调用此代码块
 @param errorBlock  获取验证码失败时调用，并返回错误信息
 */
+(void)requestForResettingPasswordWithPhoneNumber:(NSString *)phoneNumber phoneCode:(NSString *)phoneCode password:(NSString *)password withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;



/**
 登录
 
 @param userName   用户名/手机号
 @param password   密码
 @param completion 成功时调用此方法
 @param errorBlock 失败时调用此方法并返回错误信息
 */
+(void)requestForLoginWithUserName:(NSString *)userName password:(NSString *)password withSuccessBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;





@end
