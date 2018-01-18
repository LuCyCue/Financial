//
//  SettingViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingSwitchCell.h"
#import "SettingModel.h"
#import "LoginViewViewController.h"
#import "NetWorkApi.h"
#import "DataBase.h"

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
    BOOL isNeedPsw = [PersonalSettings sharedPersonalSettings].isNeedPswLogin;
    BOOL isNeedSaveToServer = [PersonalSettings sharedPersonalSettings].isNeedSaveToServer;
    SettingModel *settingM0 = [SettingModel settingModelWithTitle:@"修改App密码" IsHaveSwitch:NO SwitchOn:NO];
    SettingModel *settingM1 = [SettingModel settingModelWithTitle:@"密码登录App" IsHaveSwitch:YES SwitchOn:isNeedPsw];
    SettingModel *settingM2 = [SettingModel settingModelWithTitle:@"从服务器同步数据" IsHaveSwitch:NO SwitchOn:NO];
    SettingModel *settingM3 = [SettingModel settingModelWithTitle:@"保存到服务器" IsHaveSwitch:YES SwitchOn:isNeedSaveToServer];
  
   
    _dataSource = @[@[settingM0,settingM1],@[settingM2,settingM3]];
    
    
}
- (void)setUpSubViews
{
    self.title = @"设置";
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingSwitchCell" bundle:nil] forCellReuseIdentifier:settingCellID1];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *array = _dataSource[section];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cc_ScreenWidth, 30.f)];
    view.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *array = _dataSource[indexPath.section];
    SettingModel *settingM = array[indexPath.row];
    SettingSwitchCell *cell = [self.tableView dequeueReusableCellWithIdentifier:settingCellID1];
    cell.settingM = settingM;
    cc_WeakSelf(self)
    cell.switchChange = ^(BOOL isOn, NSString *title) {
        cc_StrongSelf(self)
        if ([title isEqualToString:@"密码登录App"]) {
            if (isOn && ![PersonalSettings sharedPersonalSettings].psw) {
                [self setLoginPassword];
            }else{
                 [PersonalSettings sharedPersonalSettings].isNeedPswLogin = isOn;
            }
            AppDelegate *appd = (AppDelegate *)kAppDelegate;
            appd.isLogined = YES;
        }else{
             [PersonalSettings sharedPersonalSettings].isNeedSaveToServer = isOn;
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setLoginPassword];
    }else if(indexPath.section == 1 && indexPath.row == 0){
        [self downloadDataFromServer];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark --Custom Method
- (void)setLoginPassword
{
    cc_WeakSelf(self)
    if (![PersonalSettings sharedPersonalSettings].psw) {
        [CCShowMessage showMessage:@"您还未设置App密码，请先设置" title:@"提示" actions:@[@"确定",@"取消"] inViewController:self handler:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"确定"]) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                LoginViewViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginViewViewController"];
                loginVC.type = PasswordTypeSet;
                [weakself presentViewController:loginVC animated:YES completion:nil];
                [PersonalSettings sharedPersonalSettings].isNeedPswLogin = YES;
            }else{
                SettingSwitchCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                cell.SwhOn.on = NO;
            }
        }];
    }else{
        [CCShowMessage showMessage:@"您确定要修改现有密码吗？" title:@"提示" actions:@[@"确定",@"取消"] inViewController:self handler:^(UIAlertAction *action) {
            if ([action.title isEqualToString:@"确定"]) {
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
                LoginViewViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginViewViewController"];
                loginVC.type = PasswordTypeReset;
                [weakself presentViewController:loginVC animated:YES completion:nil];
            }
        }];
    }
}

- (void)downloadDataFromServer
{
    [CCShowMessage showMessage:@"您确定要同步服务器上的数据吗？" title:@"提示" actions:@[@"确定",@"取消"] inViewController:self handler:^(UIAlertAction *action) {
        if ([action.title isEqualToString:@"确定"]) {
            [SVProgressHUD showWithStatus:@"正在同步"];
            [NetWorkApi getAllFinancialFromServer:^(BOOL isSuccess, NSArray *array) {
                if (isSuccess) {
                    [[DataBase sharedDataBase] truncateTable];
                    [[DataBase sharedDataBase] addFinancialsWithArray:array];
                    [SVProgressHUD showSuccessWithStatus:@"同步成功"];
                    [kNotificationCenter postNotificationName:@"downloadDataFromServerSucess" object:nil];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"同步失败"];
                }
            }];
        }
    }];
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
