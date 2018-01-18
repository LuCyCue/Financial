//
//  SettingModel.m
//  PersonFinancial
//
//  Created by mac on 2018/1/18.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "SettingModel.h"

@implementation SettingModel

- (instancetype)initWithTitle:(NSString *)title IsHaveSwitch:(BOOL)isHaveSwitch SwitchOn:(BOOL)isOn
{
    self = [super init];
    if (self) {
        _title = title;
        _isHaveSwitch = isHaveSwitch;
        _isOn = isOn;
    }
    return self;
}

+ (instancetype)settingModelWithTitle:(NSString *)title IsHaveSwitch:(BOOL)isHaveSwitch SwitchOn:(BOOL)isOn
{
    return [[self alloc]initWithTitle:title IsHaveSwitch:isHaveSwitch SwitchOn:isOn];
}
@end
