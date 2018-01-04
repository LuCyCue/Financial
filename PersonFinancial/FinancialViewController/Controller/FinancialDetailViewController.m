//
//  FinancialDetailViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "FinancialDetailViewController.h"
#import "FinancialDetailTableViewCell.h"
#import "RemaksCell.h"
#import "DataBase.h"
#import "DisplayModel.h"

@interface FinancialDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)   UITableView  *tableV;
@property (nonatomic, strong)   NSMutableArray *datasource;
@property (nonatomic, assign)   BOOL  isneedSave;

@end

static NSString *FinancailDetailCellID = @"FinancailDetailCellID";
static NSString *RemaksCellID = @"RemaksCellID";

@implementation FinancialDetailViewController

- (instancetype)initWithDetailM:(FinancialDetail *)detail Mode:(ViewControllerMode) mode
{
    self = [super init];
    if (self) {
        _detailM = detail;
        _mode = mode;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTableview];
    self.isneedSave = YES;
}
-(void)setupTableview
{
    self.view.autoresizingMask = NO;
    _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, cc_ScreenWidth, cc_ScreenHeight) style:UITableViewStylePlain];
    _tableV.delegate = self;
    _tableV.dataSource = self;
    _tableV.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _tableV.allowsSelection = NO;
    [self.view addSubview:_tableV];
    [_tableV registerNib:[UINib nibWithNibName:@"FinancialDetailTableViewCell" bundle:nil] forCellReuseIdentifier:FinancailDetailCellID];
    [_tableV registerNib:[UINib nibWithNibName:@"RemaksCell" bundle:nil] forCellReuseIdentifier:RemaksCellID];
    _tableV.estimatedRowHeight = 50.f;
    _tableV.rowHeight = UITableViewAutomaticDimension;
    
    
}
- (void)setupNavBar
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveEdit)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)saveEdit
{
    //添加新记录模式
    if (_mode == ViewControllerModeNew) {
        [[DataBase sharedDataBase] addFinancial:_detailM];

    }else if(_mode == ViewControllerModeEdit){
        [[DataBase sharedDataBase] updateFinancial:_detailM];
    }
    [self.delegate financialDidChange];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --Lazy load
- (NSMutableArray *)datasource
{
    if (!_datasource) {
        NSArray *array = [_detailM transform2DisplayArray];
        _datasource = [NSMutableArray arrayWithArray:array];
    }
    return _datasource;
}

#pragma mark --UITableviewDataSource && Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DisplayModel *detail = self.datasource[indexPath.row];
    __weak typeof (self) WeakSelf = self;
    if (indexPath.row <= 10) {
        FinancialDetailTableViewCell *cell  = [_tableV dequeueReusableCellWithIdentifier:FinancailDetailCellID];
        cell.LabTitle.text = detail.title;
        cell.TexContent.text = detail.content;
        if ([detail.title isEqualToString:@"时间:"]) {
            cell.isNeedInputDate = YES;
        }
        cell.contentChange = ^(NSString *title, NSString *content) {
            [WeakSelf dataSourceChangeWithTitle:title Content:content];
        };
        return  cell;
    }else{
        RemaksCell *cell = [_tableV dequeueReusableCellWithIdentifier:RemaksCellID];
        cell.LabTitle.text = detail.title;
        cell.TexContent.text = detail.content;
        cell.contenDidChange = ^(NSString *title, NSString *content) {
            [WeakSelf dataSourceChangeWithTitle:title Content:content];
        };
        return cell;
    }
    
}



#pragma mark --custom Methods
- (void)dataSourceChangeWithTitle:(NSString *)title Content:(NSString *)content
{
    DisplayModel *displayM = [DisplayModel displayModelWithTitle:title Content:content];
    [self.detailM changePropertyWithDisplayModel:displayM];
    if (self.isneedSave) {
        self.isneedSave = NO;
        [self setupNavBar];
    }
    //刷新显示数据
    NSArray *array = [_detailM transform2DisplayArray];
    _datasource = [NSMutableArray arrayWithArray:array];
}
#pragma mark --MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

















@end
