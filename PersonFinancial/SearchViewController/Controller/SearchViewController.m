//
//  SearchViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/8.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "SearchViewController.h"
#import "cc_SearchView.h"
#import "FinancialTableViewCell.h"
#import "FinancialDetail.h"
#import "FinancialDetailViewController.h"
#import "DataBase.h"

@interface SearchViewController ()<cc_searchViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)      cc_SearchView  *searchView;

@property (nonatomic, strong)   UITableView   *tableV;

@property (nonatomic, copy)     NSMutableArray *datasource;

@end

static NSString *const searchCellId = @"searchCellId";
@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self setupTableview];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)setUpSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    cc_SearchView *searchView = [[cc_SearchView alloc]init];
    searchView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    self.searchView = searchView;
    self.searchView.delegate = self;
    [self.view addSubview:_searchView];
    
}
-(void)setupTableview
{
    self.view.autoresizingMask = NO;
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, cc_ScreenWidth, cc_ScreenHeight-64) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    [self.view addSubview:_tableV];
    [_tableV registerNib:[UINib nibWithNibName:@"FinancialTableViewCell" bundle:nil] forCellReuseIdentifier:searchCellId];
    _tableV.tableFooterView = [[UIView alloc]init];
    
}

#pragma mark --SearchViewDelegate
- (void)startSearchWithText:(NSString *)text{
    self.datasource = [[DataBase sharedDataBase] getFinancialWithText:text];
    [self.tableV reloadData];
}
- (void)dismissSearchViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --UITableviewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FinancialDetail *financialM = self.datasource[indexPath.row];
    FinancialTableViewCell *cell = [_tableV dequeueReusableCellWithIdentifier:searchCellId];
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
    FinancialDetailViewController *detailVC = [[FinancialDetailViewController alloc]initWithDetailM:financialM Mode:ViewControllerModeLookUp];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark --MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
