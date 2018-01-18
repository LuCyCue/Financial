//
//  PersonalSettings.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalSettings : NSObject


@property (nonatomic, strong)     NSString   *psw;

@property (nonatomic, assign)     BOOL   isNeedPswLogin;

@property (nonatomic, assign)     BOOL   isNeedSaveToServer;


- (void)getSettings;

+ (instancetype)sharedPersonalSettings;

@end
