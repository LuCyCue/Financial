//
//  LoginViewViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/20.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "LoginViewViewController.h"
#import "PasswordView.h"

@interface LoginViewViewController ()
@property (weak, nonatomic) IBOutlet PasswordView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *LabTitle;

@property (nonatomic, strong)    NSMutableString *passwordStr;

@property (nonatomic, strong)    NSMutableString *passwordFirst;

@end
@implementation LoginViewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _passwordStr = [NSMutableString stringWithString:@""];
    _passwordFirst = [NSMutableString stringWithString:@""];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (_type == PasswordTypeReset) {
        _LabTitle.text = @"请输入原密码";
    }
}
#pragma mark --actions

- (IBAction)inputOne:(id)sender {
    [self inputPassword:1];
}
- (IBAction)inputTwo:(id)sender {
     [self inputPassword:2];
}
- (IBAction)inputThree:(id)sender {
     [self inputPassword:3];
}
- (IBAction)inputFour:(id)sender {
     [self inputPassword:4];
}
- (IBAction)inputFive:(id)sender {
     [self inputPassword:5];
}
- (IBAction)inputSix:(id)sender {
     [self inputPassword:6];
}
- (IBAction)inputSeven:(id)sender {
     [self inputPassword:7];
}
- (IBAction)inputEight:(id)sender {
     [self inputPassword:8];
}
- (IBAction)inputNine:(id)sender {
     [self inputPassword:9];
}
- (IBAction)inputZero:(id)sender {
     [self inputPassword:0];
}
- (IBAction)ResetPsw:(id)sender {
    [self inputPassword:100];
}

- (void)inputPassword:(NSInteger)num
{
    if (num == 100) {
        if (_passwordStr.length) {
             [_passwordStr deleteCharactersInRange:NSMakeRange(_passwordStr.length-1, 1)];
        }
    }else{
        [_passwordStr appendString:[NSString stringWithFormat:@"%ld",num]];
    }
    if (_passwordStr.length == 6) {
        if (_type == PasswordTypeLogin) { //登录
            if ([_passwordStr isEqualToString:[PersonalSettings sharedPersonalSettings].psw]) {
                [self dismissViewControllerAnimated:YES completion:nil];
                AppDelegate *appd = (AppDelegate *)kAppDelegate;
                appd.isLogined = YES;
            }else{
                cc_WeakSelf(self)
                [CCShowMessage showMessage:@"密码错误" title:@"提示" actions:@[@"确定"] inViewController:self handler:^(UIAlertAction *action) {
                    [_passwordStr deleteCharactersInRange:NSMakeRange(0, _passwordStr.length)];
                    weakself.passwordView.inputCount = 0;
                }];
            }
        }else if(_type == PasswordTypeSet){ //第一次设密码
            if (_passwordFirst.length != 6) {
                _passwordFirst = [_passwordStr mutableCopy];
                [self performSelector:@selector(ensurePassword) withObject:nil afterDelay:0.5];
            }else{
                cc_WeakSelf(self)
                if ([_passwordStr isEqualToString:_passwordFirst]) {
                    [PersonalSettings sharedPersonalSettings].psw = _passwordStr;
                    [CCShowMessage showMessage:@"设置成功" title:@"提示" actions:@[@"确定"] inViewController:self handler:^(UIAlertAction *action) {
                        [weakself dismissViewControllerAnimated:YES completion:nil];
                    }];
                }else{
                    [CCShowMessage showMessage:@"前后密码不一致，请重新输入" title:@"提示" actions:@[@"确定"] inViewController:self handler:^(UIAlertAction *action) {
                        weakself.passwordStr = [NSMutableString stringWithString:@""];
                        weakself.passwordFirst = [NSMutableString stringWithString:@""];
                        weakself.passwordView.inputCount = weakself.passwordStr.length;
                        weakself.LabTitle.text = @"请输入密码";
                    }];
                }
            }
        }else{ //重置密码
            if ([_passwordStr isEqualToString:[PersonalSettings sharedPersonalSettings].psw]) {
                [self performSelector:@selector(turnSetPassword) withObject:nil afterDelay:0.5];
            }else{
                cc_WeakSelf(self)
                [CCShowMessage showMessage:@"密码错误,请重新输入" title:@"提示" actions:@[@"确定"] inViewController:self handler:^(UIAlertAction *action) {
                    [_passwordStr deleteCharactersInRange:NSMakeRange(0, _passwordStr.length)];
                    weakself.passwordView.inputCount = 0;
                }];
            }
        }
        
    }
    _passwordView.inputCount = _passwordStr.length;
    
}

- (void)ensurePassword
{
    _passwordStr = [NSMutableString stringWithString:@""];
    _passwordView.inputCount = _passwordStr.length;
    _LabTitle.text = @"请确认密码";
}
- (void)turnSetPassword
{
    _passwordStr = [NSMutableString stringWithString:@""];
    _passwordView.inputCount = _passwordStr.length;
    _type = PasswordTypeSet;
    _LabTitle.text = @"请输入新密码";
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
