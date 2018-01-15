//
//  LoginViewViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/20.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "LoginViewViewController.h"
#import "PasswordView.h"
#import "CCShowMessage.h"

@interface LoginViewViewController ()
@property (weak, nonatomic) IBOutlet PasswordView *passwordView;

@property (nonatomic, strong)    NSMutableString *passwordStr;

@end
static NSString *correctPsw = @"900907";
@implementation LoginViewViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _passwordStr = [NSMutableString stringWithString:@""];
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
        if ([_passwordStr isEqualToString:correctPsw]) {
            [self dismissViewControllerAnimated:YES completion:nil];
            AppDelegate *appd = (AppDelegate *)kAppDelegate;
            appd.isLogined = YES;
        }else{
            [CCShowMessage showMessage:@"密码错误" title:@"提示" actions:@[@"确定"] inViewController:self handler:^(UIAlertAction *action) {
                [_passwordStr deleteCharactersInRange:NSMakeRange(0, _passwordStr.length)];
                _passwordView.inputCount = 0;
            }];
        }
    }
    _passwordView.inputCount = _passwordStr.length;
    
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
