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

@interface FinancialViewController ()<UITableViewDelegate, UITableViewDataSource>

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
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addNewRecord)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editRecord)];
    self.navigationItem.leftBarButtonItem = leftItem;
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
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)editRecord
{
    
}
#pragma mark --UITableviewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSArray *subData = self.datasource[section];
//    return subData.count;
    return self.datasource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   // return self.datasource.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialDetail *financialM = self.datasource[indexPath.row];
    FinancialTableViewCell *cell = [_tableV dequeueReusableCellWithIdentifier:FinanciallID];
    [cell setDatasource:financialM];
    return cell;
}

#pragma mark --MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}










@end
