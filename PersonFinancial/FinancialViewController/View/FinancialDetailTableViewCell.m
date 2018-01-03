//
//  FinancialDetailTableViewCell.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/28.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "FinancialDetailTableViewCell.h"
#import "UITextField+BirthDay.h"

@implementation FinancialDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _TexContent.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setIsNeedInputDate:(BOOL)isNeedInputDate
{
    _isNeedInputDate = isNeedInputDate;
    [_TexContent setBirthDayEditMode];
}
#pragma mark --UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField           
{
    if (_contentChange) {
        _contentChange(_LabTitle.text,_TexContent.text);
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}



@end
