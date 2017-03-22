//
//  FirstViewController.m
//  HJFrameworkDemo
//
//  Created by HJ on 2016/11/11.
//  Copyright © 2016年 HJ. All rights reserved.
//

#import "FirstViewController.h"
#import "HJAlertAction.h"

#define SC_WIDTH    [UIScreen mainScreen].bounds.size.width//屏幕宽度
#define SC_HEIGHT   [UIScreen mainScreen].bounds.size.height//屏幕高度



@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong)  UITableView *mainTableView;

@end

@implementation FirstViewController

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
    self.title = @"个人资料";
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
            cell.textLabel.text = @"提示状态";
        }
            break;
        case 1:
        {
            cell.textLabel.text = @"两个提示框";
        }
            break;
        case 2:
        {
            cell.textLabel.text = @"一个按钮提示框";
        }
            break;
        case 3:
        {
            
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
            [HJAlertAction showMessage:@"这里是提示信息" withSuperView:self.view withMessageMode:HJAlertViewModeTop];
        }
            break;
        case 1:
        {
            [HJAlertAction addAlertTitle:@"提示" message:@"这里是提示信息这里是提示信息这里是提示信息这里是提示信息这里是提示信息这里是提示信息" withCancelButton:@"取消" confirmButton:@"确定" withClickConfirmBlock:^{
                NSLog(@"确定");
            } withCancelBlock:^{
                NSLog(@"取消");
            }];
        }
            break;
        case 2:
        {
            [HJAlertAction addAlertTitle:nil message:@"这里是提示信息这里是提示信息这里是提示信息这里是提示信息这里是提示信息这里是提示信息" withCancelButton:@"知道了" confirmButton:nil withClickConfirmBlock:nil withCancelBlock:^{
                
            }];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
