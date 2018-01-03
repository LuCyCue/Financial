//
//  RemaksCell.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/28.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "RemaksCell.h"

@implementation RemaksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _TexContent.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark --UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (_contenDidChange) {
        _contenDidChange(_LabTitle.text,_TexContent.text);
    }
}
@end
