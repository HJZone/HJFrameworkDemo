//
//  HJDatabaseAction.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "HJDatabaseAction.h"
#import "FMDB.h"

static FMDatabase* _fmdb;

@implementation HJDatabaseAction
#pragma mark 数据库基本操作
//分享数据表,即打开数据表,打开以后可以进行相应的操作
+ (FMDatabase*)shareDatabase
{
    _fmdb = [[FMDatabase alloc] initWithPath:[self getFilePath]];
    [self openDatabase];
    return _fmdb;
}

//关闭数据库
+ (void)closeDatabase
{
    [_fmdb close];
}

//打开数据库
+ (void)openDatabase
{
    [_fmdb open];
    [_fmdb setShouldCacheStatements:YES];
}
//获取沙盒路径,并创建数据库文件
+ (NSString*)getFilePath
{
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"database"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return [filePath stringByAppendingString:@"/database.sqlite"];
}

#pragma - mark creatPersonInfoTable

//创建个人信息表
+ (void)creatPersonalInfoTable
{
    [self shareDatabase];
    [self openDatabase];
    NSLog(@"NSHomeDirectory======%@", NSHomeDirectory());
    BOOL isCreateSuccess = [_fmdb tableExists:@"personalInfoTable"];
    if (isCreateSuccess == NO) {
        [_fmdb executeUpdate:@"CREATE TABLE  personalInfoTable (name TEXT, age TEXT,height TEXT, weight TEXT,address TEXT,telephone TEXT, work TEXT)"];
    }
    
    [self closeDatabase];
}

//更新个人信息表数据
+ (void)updatePersonInfoWithPersonalInfoModel:(HJ_PersonalModel *)personModel withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString *))errorBlock
{
    [self shareDatabase];
    [self openDatabase];
    FMResultSet* resultSet = [_fmdb executeQuery:@"select *from personalInfoTable where name = %@",personModel.name];
    if ([resultSet next]) {
        
        //检测用户数据表是否已经存在用户信息，如果存在 直接更新数据即可
        [_fmdb executeUpdateWithFormat:@"update personalInfoTable set name = %@,age = %@, height = %@,weight = %@,adress = %@,telephone = %@,work = %@", personModel.name,personModel.age,personModel.height,personModel.weight,personModel.address,personModel.telephone,personModel.work];
        completion();
    }
    else { //如果不存在，则重新插入一条数据
        errorBlock(@"未找到用户信息");
    }
    [self closeDatabase];
}

+(void)insertPesonalInfoWithModel:(HJ_PersonalModel *)personModel withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString *))errorBlock
{
    [self shareDatabase];
    [self openDatabase];
    FMResultSet* resultSet = [_fmdb executeQuery:@"select *from personalInfoTable where name = %@",personModel.name];
    if ([resultSet next]) {
        
        //检测用户数据是否已经存在，如果存在 直接更新数据即可
        [_fmdb executeUpdateWithFormat:@"update personalInfoTable set name = %@,age = %@, height = %@,weight = %@,adress = %@,telephone = %@,work = %@", personModel.name,personModel.age,personModel.height,personModel.weight,personModel.address,personModel.telephone,personModel.work];
    }
    else { //如果不存在，则重新插入一条数据
        [_fmdb executeUpdateWithFormat:@"INSERT INTO personalInfoTable (name,age,height,weight,adress,telephone,work)VALUES( %@ , %@ , %@ , %@ ,%@ , %@ , %@  )",personModel.name,personModel.age,personModel.height,personModel.weight,personModel.address,personModel.telephone,personModel.work];
    }
    [self closeDatabase];
}


+(void)deletePersonalInfoWithUserName:(NSString *)name withCompletionBlock:(void (^)())completion withErrorBlock:(void (^)(NSString *))errorBlock
{
    [self shareDatabase];
    [self openDatabase];
    
    FMResultSet* resultSet = [_fmdb executeQuery:@"select *from personalInfoTable where name = %@",name];
    if ([resultSet next])
    {
        BOOL isDelete = [_fmdb executeUpdate:@"delete from personalInfoTable where name = ?",name];
        
        if (isDelete == YES)
        {
            completion();
        }
        else
        {
            errorBlock(@"删除失败，请重试");
        }
    }
    else
    {
        errorBlock(@"未查询到相关数据");
    }
    [self closeDatabase];
}

//查询个人信息表
+ (void)queryPersonalInfoTableWithCompletionBlock:(void (^)(NSArray<HJ_PersonalModel *> *))completion withErrorBlock:(void (^)(NSString *))errorBlock
{
    
    [self shareDatabase];
    [self openDatabase];
    
    FMResultSet *set = [_fmdb executeQuery:@"select *from personalInfoTable "];
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    while ([set next])
    {
        HJ_PersonalModel *model = [[HJ_PersonalModel alloc]init];
        model.name = [set stringForColumn:@"name"];
        model.age = [set stringForColumn:@"age"];
        model.height = [set stringForColumn:@"height"];
        model.weight = [set stringForColumn:@"weight"];
        model.telephone = [set stringForColumn:@"telephone"];
        model.address = [set stringForColumn:@"adress"];
        model.work = [set stringForColumn:@"work"];
        
        [array addObject:model];
        
    }
    
    if (array.count == 0) {
        errorBlock(@"未查询到数据");
    }
    else
    {
        completion(array);
    }
    
    [self closeDatabase];
    
}

//删除组信息表
+ (void)deletePersonalInfoTable
{
    
    [self shareDatabase];
    [self openDatabase];
    [_fmdb executeUpdate:@"DELETE  FROM personalInfoTable"];
    [self closeDatabase];
}


@end
