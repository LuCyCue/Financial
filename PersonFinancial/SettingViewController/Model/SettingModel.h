//
//  SettingModel.h
//  PersonFinancial
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingModel : NSObject

@property (nonatomic, strong)     NSString  *title;

@property (nonatomic, assign)     BOOL    isHaveSwitch;

@property (nonatomic, assign)     BOOL    isOn;

+ (instancetype)settingModelWithTitle:(NSString *)title IsHaveSwitch:(BOOL)isHaveSwitch SwitchOn:(BOOL)isOn;

@end
