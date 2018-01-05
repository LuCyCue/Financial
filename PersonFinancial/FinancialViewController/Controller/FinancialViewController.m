//
//  FinancialViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/25.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "FinancialViewController.h"
#import "FinancialDetail.h"
#import "FinancialTableViewCell.h"
#import "FinancialDetailViewController.h"
#import "DataBase.h"

@interface FinancialViewController ()<UITableViewDelegate, UITableViewDataSource,FinancialChangeDelegate>

@property (nonatomic, strong)   UITableView   *tableV;

@property (nonatomic, copy)     NSMutableArray *datasource;

@end
static NSString *const FinanciallID = @"FinancialID";

@implementation FinancialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self setupTableview];
    
}
-(void)setupTableview
{
    self.view.autoresizingMask = NO;
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, cc_ScreenWidth, cc_ScreenHeight) style:UITableViewStyleGrouped];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view addSubview:_tableV];
    [_tableV registerNib:[UINib nibWithNibName:@"FinancialTableViewCell" bundle:nil] forCellReuseIdentifier:FinanciallID];
    
    
}
- (void)setupNavBar
{
    self.title = @"帐目";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(addNewRecord) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
  
  
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editRecord)];
//    self.navigationItem.leftBarButtonItem = leftItem;
}
#pragma mark --lazy load
- (NSMutableArray *)datasource
{
    if (!_datasource) {
       _datasource = [[DataBase sharedDataBase] getAllFinancial];
    }
    return _datasource;
}

#pragma mark --actions

- (void)addNewRecord
{
    FinancialDetailViewController *detailVC = [[FinancialDetailViewController alloc]initWithDetailM:[FinancialDetail new] Mode:ViewControllerModeNew];
    detailVC.delegate =self;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)editRecord
{
    
}
#pragma mark --UITableviewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialDetail *financialM = self.datasource[indexPath.row];
    FinancialTableViewCell *cell = [_tableV dequeueReusableCellWithIdentifier:FinanciallID];
    [cell setDatasource:financialM];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialDetail *financialM = self.datasource[indexPath.row];
    FinancialDetailViewController *detailVC = [[FinancialDetailViewController alloc]initWithDetailM:financialM Mode:ViewControllerModeEdit];
    detailVC.delegate = self;
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
//左滑编辑模式
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataBase sharedDataBase] deleteFinancial:_datasource[indexPath.row]];
        [_datasource removeObjectAtIndex:indexPath.row];
        [_tableV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

//设置左滑删除按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置右边按钮的文字
    return @"删除";
}
#pragma mark FinancialChangeDelegate
- (void)financialDidChange
{
    [self reloadTableView];
}
- (void)reloadTableView
{
    _datasource = [[DataBase sharedDataBase] getAllFinancial];
    [self.tableV reloadData];
}
#pragma mark --MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
