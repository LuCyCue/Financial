//
//  SettingViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingSwitchCell.h"

@interface SettingViewController ()

@property (nonatomic, strong)    NSArray   *dataSource;
@end

static NSString *const settingCellID1 = @"settingCellID1";
@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self setUpSubViews];
    
}
- (void)initData{
    NSArray *array1 = @[@"修改登录密码"];
    BOOL isNeedPsw = [PersonalSettings sharedPersonalSettings].isNeedPswLogin;
    BOOL isNeedSaveToServer = [PersonalSettings sharedPersonalSettings].isNeedSaveToServer;
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjects:@[@"需要密码登录",@(isNeedPsw)] forKeys:@[@"title",@"switch"]];
    NSDictionary *dic2 = [NSDictionary dictionaryWithObjects:@[@"保存到服务器",@(isNeedSaveToServer)] forKeys:@[@"title",@"switch"]];
    NSArray *array2 = @[dic1,dic2];
    _dataSource = @[array1,array2];
    
    
}
- (void)setUpSubViews
{
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingSwitchCell" bundle:nil] forCellReuseIdentifier:settingCellID1];
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

    NSArray *array = _dataSource[section];
    return array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _dataSource[indexPath.section];
    SettingSwitchCell *cell = [self.tableView dequeueReusableCellWithIdentifier:settingCellID1];
    if (indexPath.section == 0) {
        
    }else{
        NSDictionary  *dic = array[indexPath.row];
        cell.LabTitle.text = [dic objectForKey:@"title"];
        cell.SwhOn.state = [((NSNumber*)[dic objectForKey:@"switch"]) boolValue];
    }
    return cell;
}


@end
