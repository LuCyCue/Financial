//
//  PersonalSettings.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "PersonalSettings.h"

#define default_key_psw             @"Password"
#define default_key_saveToServer    @"isNeedSaveToServer"
#define default_key_loginNeedPsw    @"isNeedPswLogin"

@implementation PersonalSettings

kGCD_SHAREINSTANCE_CLASS(PersonalSettings)

- (void)getSettings
{

    NSString *psw = [kUserDefaults objectForKey:default_key_psw];
    self.psw = psw;
    
    NSNumber *isNeedSaveToServer = [kUserDefaults objectForKey:default_key_saveToServer];
    if (!isNeedSaveToServer) {
        self.isNeedSaveToServer = YES;
    }else{
        self.isNeedSaveToServer = [isNeedSaveToServer boolValue];
    }
    
    NSNumber *isNeedPswLogin = [kUserDefaults objectForKey:default_key_loginNeedPsw];
    if (!isNeedPswLogin) {
        self.isNeedPswLogin = NO;
    }else{
        self.isNeedPswLogin = [isNeedPswLogin boolValue];
    }
}


- (void)setPsw:(NSString *)psw
{
    _psw = psw;
    [kUserDefaults setObject:psw forKey:default_key_psw];
    [kUserDefaults synchronize];
}

- (void)setIsNeedPswLogin:(BOOL)isNeedPswLogin
{
    _isNeedPswLogin = isNeedPswLogin;
    [kUserDefaults setObject:[NSNumber numberWithBool:isNeedPswLogin] forKey:default_key_loginNeedPsw];
    [kUserDefaults synchronize];
}

- (void)setIsNeedSaveToServer:(BOOL)isNeedSaveToServer
{
    _isNeedSaveToServer = isNeedSaveToServer;
    [kUserDefaults setObject:[NSNumber numberWithBool:isNeedSaveToServer] forKey:default_key_saveToServer];
    [kUserDefaults synchronize];
    
}


@end
