//
//  SettingSwitchCell.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingModel.h"

typedef void(^settingSwitchChangeBlock)(BOOL isOn, NSString *title);

@interface SettingSwitchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISwitch *SwhOn;

@property (weak, nonatomic) IBOutlet UILabel *LabTitle;

@property (strong, nonatomic)   SettingModel *settingM;

@property (copy, nonatomic) settingSwitchChangeBlock  switchChange;


@end
