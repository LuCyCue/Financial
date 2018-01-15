//
//  CustomerViewControllerViewController.m
//  PersonFinancial
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "CustomerViewControllerViewController.h"
#import "DataBase.h"
#import "CustomerCell.h"

@interface CustomerViewControllerViewController ()

@property (nonatomic, strong)    NSMutableArray   *dataSource;

@end

static NSString *const customerCellID = @"customerCellID";

@implementation CustomerViewControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpSubViews];
    [self initData];

}
- (void)setUpSubViews
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomerCell" bundle:nil] forCellReuseIdentifier:customerCellID];
}
- (void)initData{
    self.dataSource = [[DataBase sharedDataBase] getAllCutomer];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == 0? 1: self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomerCell *cell = [self.tableView dequeueReusableCellWithIdentifier:customerCellID];
    NSString *name = indexPath.section == 0?  @"全部" : self.dataSource[indexPath.row];
    cell.LabName.text = name;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cc_ScreenWidth, 20)];
    view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    return view;
}

#pragma mark --UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.customerCallBack) {
        self.customerCallBack(indexPath.section == 0? @"全部": self.dataSource[indexPath.row]);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    cc_Log_Dealloc;
}
@end
