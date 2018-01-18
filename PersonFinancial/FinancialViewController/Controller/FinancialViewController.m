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
#import "SearchViewController.h"
#import "NetWorkApi.h"

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
    [kNotificationCenter addObserver:self selector:@selector(reloadTableView) name:@"downloadDataFromServerSucess" object:nil];
    
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
    self.title = @"记录";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"navbar_add"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addNewRecord) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBar_search"] style:UIBarButtonItemStylePlain target:self action:@selector(goSearch)];
    leftItem.tintColor = [UIColor blackColor];
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
    detailVC.delegate =self;
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)goSearch
{
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    [self.navigationController pushViewController:searchVC animated:YES];
    
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
        __block FinancialDetail *financialM = _datasource[indexPath.row];
        if ([PersonalSettings sharedPersonalSettings].isNeedSaveToServer) {
            cc_WeakSelf(self)
            [SVProgressHUD showWithStatus:@"正在删除"];
            [NetWorkApi deleteFinancial:financialM Result:^(BOOL isSuccess, NSError *error) {
                if (isSuccess) {
                    [[DataBase sharedDataBase] deleteFinancial:financialM];
                    [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                    [weakself.datasource removeObjectAtIndex:indexPath.row];
                    [weakself.tableV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }];
        }else{
            [[DataBase sharedDataBase] deleteFinancial:financialM];
            [self.datasource removeObjectAtIndex:indexPath.row];
            [self.tableV deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
   
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
#pragma mark --custom Methods
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
- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}








@end
