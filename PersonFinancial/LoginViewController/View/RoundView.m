//
//  RoundView.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/20.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "RoundView.h"

@implementation RoundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.frame = CGRectMake(frame.origin.x, frame.origin.y, 20, 20);
    if (self) {
        self.layer.cornerRadius = 10.f;
        self.layer.borderColor = [[UIColor blackColor]CGColor];
        self.layer.borderWidth = 2.f;
    }
    return self;
}

- (void)setIsFull:(BOOL)isFull
{
    _isFull = isFull;
    self.backgroundColor = isFull? [UIColor blackColor] : [UIColor whiteColor];
}
@end
