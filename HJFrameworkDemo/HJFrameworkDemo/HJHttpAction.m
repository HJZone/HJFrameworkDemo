//
//  HJHttpAction.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "HJHttpAction.h"
#import "AFNetworking.h"

static AFHTTPSessionManager* manager;

#define TIME_OUT_INTERVAL 10;//网络超时间隔

#define APP_HOST @"http://222222222/"//外部服务器主机地址
#define SDK_HOST @""

#define SPLICE(type) [NSString stringWithFormat:@"%@%@",APP_HOST,type]
#define GET_PHONE_CODE_REGISTER_API     SPLICE(@"dyLock/code/getCode.do")//注册页面获取短信验证码

#define GET_PHONE_CODE_RECOVERY_API     SPLICE(@"dyApp/code/getCode.do")//找回密码页面获取短信验证码

#define REGISTER_SDK_API    SPLICE(@"dyLock/user/register.do")//SDK注册

#define REGISTER_APP_API    SPLICE(@"dyApp/user/register.do")//APP注册

#define RESETTING_PSW_API   SPLICE(@"dyApp/user/forgetPwd.do")//找回密码

#define LOGIN_API           SPLICE(@"dyApp/user/login.do")//登录



@implementation HJHttpAction

#pragma -mark 初始化操作
/**
 初始化AFHTTPSessionManager
 */
+(void)shareMaManager
{
    manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = TIME_OUT_INTERVAL;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/json", @"application/json", @"text/javascript", @"text/html", nil];
}
/**
 *  解析错误信息，以服务端返回的错误信息为主，接受不到服务端的错误信息时候返回系统错误信息描述error.localizedDescription
 *
 *  @param error 服务器返回的错误信息
 *
 *  @return 解析后的错误信息
 */
+ (NSString*)resolveWithError:(NSError*)error
{
    NSDictionary* dic = error.userInfo;
    
    //这是我通过验证得到的键值对，每个公司返回的错误信息可能不一样，因此用这个com.alamofire.serialization.response.error.data可能解析不到你的错误信息，这就需要各位的自己尝试了
    NSData* data = [dic objectForKey:@"com.alamofire.serialization.response.error.data"];
    
    NSString* string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (string.length == 0) {//先检测是否是系统的异常，如果是系统的错误直接返回错误信息
        return error.localizedDescription;
    }
    //如果不是系统的错误就返回服务器返回的错误信息，错误信息一般是要通过提示框展示给用户看的，因此不宜过长
    else if (string.length > 50) {//如果服务器返回的信息过长，则可能是返回的html错误，此时也可以解析，但我公司要求的是如果错误信息多的话直接显示网络异常即可
        
        return @"网络错误";
    }
    else {
        return string;
    }
}


/**
 解析带转义字符的JSON数据，返回解析后的数据（字典形式）
 
 @param jsonString 待解析的数据
 
 @return 字典类型
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    NSMutableString *responseString = [NSMutableString stringWithString:jsonString];
    NSString *character = nil;
    for (int i = 0; i < responseString.length; i ++) {
        character = [responseString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma -mark 登录注册相关

//获取短信验证码(POST)
+(void)requestForGetPhoneCodeWithPhoneNumerString:(NSString *)phoneNumber isForRegister:(BOOL)isForRegister withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock
{
    [self shareMaManager];
    
    NSDictionary *parameterDic = isForRegister == YES ? @{@"mobile" : phoneNumber ,@"content" : @"欢迎使用盾云密码锁，验证码为："}:@{@"mobile" : phoneNumber};
    
    NSString *urlString = isForRegister == YES ? GET_PHONE_CODE_REGISTER_API : GET_PHONE_CODE_RECOVERY_API;
    [manager POST:urlString parameters:parameterDic progress:^(NSProgress* _Nonnull uploadProgress) {
        
    }
          success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
              NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSLog(@"dictionary===%@",dictionary);
              NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
              if (code == 100) {
                  completion();
              }
              else
              {
                  errorBlock([dictionary objectForKey:@"data"]);
              }
              
              
          }
          failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
              NSLog(@"error===%@",error);
              errorBlock([self resolveWithError:error]);
          }];
    
}

//注册(GET)
+(void)requestFor_SDK_RegieterWithPhoneNumber:(NSString *)phoneNumber phoneCode:(NSString *)phoneCode withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock
{
    [self shareMaManager];
    
    NSDictionary *parameterDic = @{
                                   @"mobile" : phoneNumber ,
                                   @"code" : phoneCode ,
                                   @"companyId" : @"2becde9154824a3aa7c226393c916297" ,
                                   @"phoneModel" : @"2",
                                   @"sdkV" : @"1.2" ,
                                   @"systemV" : @"10.1" };
    
    [manager GET:@"" parameters:parameterDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
        if (code == 100) {
            completion();
        }
        else
        {
            errorBlock([dictionary objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

//APP完成注册(PUT)
+(void)requestFor_APP_RegisterWithPhoneNumber:(NSString *)phoneNumber password:(NSString *)password withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock
{
    [self shareMaManager];
    
    NSDictionary *parameterDic = @{
                                   @"mobile" : phoneNumber ,
                                   @"passWord" : password ,
                                   @"phoneModel" : @"2" ,
                                   @"sdkV" : @"1.2" ,
                                   @"systemV" : @"10.1" };
    
    
    NSLog(@"parameterDic==%@",parameterDic);
    [manager PUT:@"url" parameters:parameterDic success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
        if (code == 100) {
            completion();
        }
        else
        {
            errorBlock([dictionary objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        errorBlock([self resolveWithError:error]);
    }];
}

//重置密码
+(void)requestForResettingPasswordWithPhoneNumber:(NSString *)phoneNumber phoneCode:(NSString *)phoneCode password:(NSString *)password withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock
{
    [self shareMaManager];
    
    NSDictionary *parameterDic = @{@"mobile" : phoneNumber , @"passWord" : password ,  @"code" : phoneCode };
    
    [manager POST:RESETTING_PSW_API parameters:parameterDic progress:^(NSProgress* _Nonnull uploadProgress) {
        
    }
          success:^(NSURLSessionDataTask* _Nonnull task, id _Nullable responseObject) {
              NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
              
              NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
              if (code == 100) {
                  completion();
              }
              else
              {
                  errorBlock([dictionary objectForKey:@"data"]);
              }
              
              
          }
          failure:^(NSURLSessionDataTask* _Nullable task, NSError* _Nonnull error) {
              
              errorBlock([self resolveWithError:error]);
          }];
}

//登录
+(void)requestForLoginWithUserName:(NSString *)userName password:(NSString *)password withSuccessBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock
{
    [self shareMaManager];
    
    NSDictionary *parameterDic = @{
                                   @"mobile" : userName ,
                                   @"passWord" : password ,
                                   @"phoneModel" : @"2",
                                   @"pushId" : @"123" ,
                                   @"sdkV" : @"1.2" ,
                                   @"systemV" : @"123"};
    
    NSLog(@"parameterDic===%@",parameterDic);
    [manager POST:LOGIN_API parameters:parameterDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSLog(@"dictionary===%@",dictionary);
        
        NSInteger code = [[dictionary objectForKey:@"code"] integerValue];
        
        
        if (code == 100) {
            
            
            completion();
        }
        else
        {
            errorBlock([dictionary objectForKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error==%@",error);
        errorBlock([self resolveWithError:error]);
    }];
    
}


@end
