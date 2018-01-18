//
//  LoginViewViewController.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/20.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    PasswordTypeLogin,  //登录
    PasswordTypeSet,    //设置密码
    PasswordTypeReset,  //修改密码
}PasswordType;

@interface LoginViewViewController : UIViewController

@property (nonatomic, assign)    PasswordType   type;

@end
