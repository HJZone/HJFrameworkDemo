//
//  ThirdViewController.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "ThirdViewController.h"
#import "HJAlertAction.h"
#import "HJDatabaseAction.h"

#define SC_WIDTH    [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SC_HEIGHT   [UIScreen mainScreen].bounds.size.height//屏幕高度



@interface ThirdViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong)  UITableView *mainTableView;



@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addNavigationButton];
    [self addMainTableView];
    // Do any additional setup after loading the view.
}

/**
 添加导航条信息
 */
-(void)addNavigationButton
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction:)];
    leftItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//添加MainTableView
-(void)addMainTableView
{
    if (_mainTableView == nil) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SC_WIDTH, SC_HEIGHT - 64 - 49) style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _mainTableView.rowHeight = 45;
        [self.view addSubview:_mainTableView];
    }
}

#pragma -mark tabView 数据源方法

//每个分区的单元格数量
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
//区头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

//区尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

//设置单元格
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"创建数据表";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"添加信息";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"查询数据";
        }
            break;
        case 3:
        {
            cell.textLabel.text = @"删除数据表";
        }
            break;
            
        default:
            break;
    }
    
    
    
    return cell;
}
#pragma -mark cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            [HJDatabaseAction creatPersonalInfoTable];
        }
            break;
        case 1:
        {
            //[HJDatabaseAction updatePersonInfoWithPersonalInfoModel:@""];
        }
            break;
        case 2:
        {
//            [HJDatabaseAction queryPersonalInfoTableWithCompletionBlock:^(NSString *result) {
//                
//            } withErrorBlock:^(NSString *errString) {
//                
//            }];
        }
            break;
        case 3:
        {
            [HJDatabaseAction deletePersonalInfoTable];
        }
            break;
            
        default:
            break;
    }
    
    
    
}

#pragma -mark 按钮区

-(void)backButtonAction:(UIBarButtonItem *)sender
{
    
}

@end
