//
//  SettingSwitchCell.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "SettingSwitchCell.h"

@implementation SettingSwitchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)SwitchChange:(id)sender {
    UISwitch *swit = (UISwitch *)sender;
    if (_settingM.isHaveSwitch && self.switchChange) {
        self.switchChange(swit.on, _settingM.title);
    }
    
}
- (void)setSettingM:(SettingModel *)settingM
{
    _settingM = settingM;
    _LabTitle.text = settingM.title;
    _SwhOn.hidden = settingM.isHaveSwitch ? NO:YES;
    _SwhOn.on = settingM.isOn;
}
@end
