//
//  HJDatabaseAction.h
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJ_PersonalModel.h"

@interface HJDatabaseAction : NSObject

/**
 创建个人信息表
 */
+ (void)creatPersonalInfoTable;

/**
 更新个人信息表数据

 @param personModel Model
 @param completion 操作完成时调用
 @param errorBlock 操作失败时调用，并返回错误信息
 */
+ (void)updatePersonInfoWithPersonalInfoModel:(HJ_PersonalModel *)personModel withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;

/**
 插入一条用户数据

 @param personModel model
 @param completion 操作完成时调用
 @param errorBlock 操作失败时调用，并返回错误信息
 */
+ (void)insertPesonalInfoWithModel:(HJ_PersonalModel *)personModel withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;

/**
 删除指定的数据

 @param name 指定参数
 @param completion 操作完成时调用
 @param errorBlock 操作失败时调用，并返回异常信息
 */
+(void)deletePersonalInfoWithUserName:(NSString *)name withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString*))errorBlock;

/**
 查询个人信息表

 @param completion 返回查询到的用户信息数组
 @param errorBlock 操作失败时调用，返回异常信息
 */
+ (void)queryPersonalInfoTableWithCompletionBlock:(void (^)(NSArray<HJ_PersonalModel*>*))completion withErrorBlock:(void (^)(NSString*))errorBlock;

/**
 删除所有数据
 */
+ (void)deletePersonalInfoTable;

@end
