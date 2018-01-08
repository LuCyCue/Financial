//
//  HomeViewController.m
//  PersonFinancial
//
//  Created by mac on 2018/1/8.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "HomeViewController.h"
#import "DataBase.h"
#import "LoginViewViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LabTotalExpenses;
@property (weak, nonatomic) IBOutlet UILabel *LabTotalIncome;
@property (weak, nonatomic) IBOutlet UILabel *LabNetProfit;
@property (weak, nonatomic) IBOutlet UIButton *BtnRefresh;
@property (strong, nonatomic)  OverViewModel *overViewM;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupNavBar];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    AppDelegate *appd = (AppDelegate *)kAppDelegate;
    if (!appd.isLogined) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        LoginViewViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginViewViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }
}
- (void)setupSubViews
{
    self.title = @"总计";
    _BtnRefresh.layer.cornerRadius = 5.f;
    self.overViewM = [[DataBase sharedDataBase] getOverViewMessage];
}
- (void)setupNavBar
{
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navBar_setting_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(goSettings)];
    leftItem.tintColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setOverViewM:(OverViewModel *)overViewM
{
    _overViewM = overViewM;
    _LabTotalExpenses.text = self.overViewM.totalExpenses;
    _LabTotalIncome.text = self.overViewM.totalIncome;
    _LabNetProfit.text = self.overViewM.netProfit;
}
- (IBAction)refresh:(id)sender {
    self.overViewM = [[DataBase sharedDataBase] getOverViewMessage];
}
- (void)goSettings
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
