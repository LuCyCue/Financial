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
#import "NetWorkApi.h"


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
        _detailM = [detail copy];
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
    _tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableV];
    [_tableV registerNib:[UINib nibWithNibName:@"FinancialDetailTableViewCell" bundle:nil] forCellReuseIdentifier:FinancailDetailCellID];
    [_tableV registerNib:[UINib nibWithNibName:@"RemaksCell" bundle:nil] forCellReuseIdentifier:RemaksCellID];
    _tableV.estimatedRowHeight = 50.f;
    _tableV.rowHeight = UITableViewAutomaticDimension;

}
- (void)setupNavBar
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveEdit)];
    rightItem.tintColor = [UIColor blackColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)saveEdit
{
    //键盘注销第一响应者
    if ([IQKeyboardManager sharedManager].isKeyboardShowing) {
        [[IQKeyboardManager sharedManager]resignFirstResponder];
    }
    cc_WeakSelf(self)
    if (_mode == ViewControllerModeNew) {//添加新记录模式
        _detailM.ID = [[DataBase sharedDataBase]getMaxId] + 1;
        if ([PersonalSettings sharedPersonalSettings].isNeedSaveToServer) {
            [SVProgressHUD showWithStatus:@"正在保存"];
            [NetWorkApi addFinancial:_detailM Result:^(BOOL isSuccess, NSString *objectId, NSError *error) {
                if (isSuccess) {
                    weakself.detailM.objectId = objectId;
                    [[DataBase sharedDataBase] addFinancial:weakself.detailM];
                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    [weakself saveSuccess];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }
            }];
        }else{
            [[DataBase sharedDataBase] addFinancial:_detailM];
            [self saveSuccess];
        }
      
        
    }else if(_mode == ViewControllerModeEdit){//编辑模式
        if ([PersonalSettings sharedPersonalSettings].isNeedSaveToServer){
            [SVProgressHUD showWithStatus:@"正在保存"];
            [NetWorkApi updateFinancial:_detailM Result:^(BOOL isSuccess, NSError *error) {
                if (isSuccess) {
                    [[DataBase sharedDataBase] updateFinancial:weakself.detailM];
                    [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    [weakself saveSuccess];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"保存失败"];
                }
            }];
        }else{
            [[DataBase sharedDataBase] updateFinancial:_detailM];
            [self saveSuccess];
        }
       
    }
  
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
        if (WeakSelf.mode == ViewControllerModeLookUp) {
            cell.TexContent.userInteractionEnabled = NO;
        }else{
            if ([detail.title isEqualToString:@"时间:"]) {
                cell.isNeedInputDate = YES;
            }else if([detail.title isEqualToString:@"利润:"]){
                cell.TexContent.userInteractionEnabled = NO;
            }
        }
       
        cell.contentChange = ^(NSString *title, NSString *content) {
            [WeakSelf dataSourceChangeWithTitle:title Content:content];
        };
        return  cell;
    }else{
        RemaksCell *cell = [_tableV dequeueReusableCellWithIdentifier:RemaksCellID];
        cell.LabTitle.text = detail.title;
        cell.TexContent.text = detail.content;
        if (WeakSelf.mode == ViewControllerModeLookUp) {
            cell.TexContent.userInteractionEnabled = NO;
        }
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
    [_tableV reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:6 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)saveSuccess
{
    if([self.delegate respondsToSelector:@selector(financialDidChange)]){
        [self.delegate financialDidChange];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
   
}
#pragma mark --MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    cc_Log_Dealloc;
}
















@end
