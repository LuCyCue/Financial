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
- (void)textViewDidChange:(UITextView *)textView
{
    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
    CGSize newSize = [textView sizeThatFits:maxSize];
    bounds.size = newSize;
    textView.bounds = bounds;
    // 让 table view 重新计算高度
    UITableView *tableView = [self tableView];
    //只会重新加载tableviewcell的高度
    [tableView beginUpdates];
    [tableView endUpdates];
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
@end
