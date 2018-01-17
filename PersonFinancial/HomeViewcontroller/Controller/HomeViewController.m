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
#import "UITextField+BirthDay.h"
#import "CustomerViewControllerViewController.h"
#import "NetWorkApi.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LabTotalExpenses;
@property (weak, nonatomic) IBOutlet UILabel *LabTotalIncome;
@property (weak, nonatomic) IBOutlet UILabel *LabNetProfit;
@property (weak, nonatomic) IBOutlet UIButton *BtnRefresh;
@property (weak, nonatomic) IBOutlet UILabel *LabCustomer;

@property (weak, nonatomic) IBOutlet UITextField *TexStartTime;

@property (weak, nonatomic) IBOutlet UITextField *TexEndTime;

@property (strong, nonatomic)  OverViewModel *overViewM;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubViews];
    [self setupNavBar];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    NSString *startTime = [[DataBase sharedDataBase] getMinTime];
    NSString *endTime = [[DataBase sharedDataBase] getMaxTime];
    self.overViewM = [[DataBase sharedDataBase] getOverViewMessageWithStartTime:startTime EndTime:endTime CutomerName:@"全部"];
    
    [_TexStartTime setBirthDayEditMode];
    [_TexEndTime setBirthDayEditMode];
    
    _LabCustomer.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeCustomer)];
    [_LabCustomer  addGestureRecognizer:tapGesture];
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
    _TexStartTime.text = self.overViewM.startTime;
    _TexEndTime.text = self.overViewM.endTime;
    _LabCustomer.text = self.overViewM.customer;
}
- (IBAction)refresh:(id)sender {
    self.overViewM = [[DataBase sharedDataBase] getOverViewMessageWithStartTime:_TexStartTime.text EndTime:_TexEndTime.text CutomerName:_LabCustomer.text];
}

- (void)changeCustomer
{
    CustomerViewControllerViewController *customerVC = [[CustomerViewControllerViewController alloc]init];
    cc_WeakSelf(self)
    customerVC.customerCallBack = ^(NSString *name) {
        weakself.LabCustomer.text = name;
    };
    [self.navigationController pushViewController:customerVC animated:YES];
}
- (void)goSettings
{
//    [NetWorkApi getAllFinancialFromServer:^(BOOL isSuccess, NSArray *array) {
//        if (isSuccess) {
//            [[DataBase sharedDataBase] addFinancialsWithArray:array];
//        }
//    }];
    [[DataBase sharedDataBase] truncateTable];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
