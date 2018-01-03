//
//  PasswordView.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/20.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "PasswordView.h"
#import "RoundView.h"

#define password_length  6
@implementation PasswordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}
- (void)initData
{
    _ArrayMRoundViews = [NSMutableArray array];
    for (int i = 0; i < password_length; i++) {
        RoundView *roudView = [[RoundView alloc]init];
        [self addSubview:roudView];
        [_ArrayMRoundViews addObject:roudView];
        _inputCount = 0;
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    int i = 0;
    CGFloat width = (self.frame.size.width - 20) / 5;
    for (RoundView *roudV in _ArrayMRoundViews) {
        roudV.center = CGPointMake(i * width + 10, self.frame.size.height / 2);
        i++;
    }
}

- (void)setInputCount:(NSInteger)inputCount
{
    _inputCount = inputCount;
    for (int i = 0; i < password_length; i++) {
        RoundView *roudView = _ArrayMRoundViews[i];
        [roudView setIsFull:i < inputCount? YES : NO];
    }
}







@end
