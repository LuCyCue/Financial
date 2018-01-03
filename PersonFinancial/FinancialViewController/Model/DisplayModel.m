//
//  DisplayModel.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "DisplayModel.h"

@implementation DisplayModel

- (instancetype)initWithTitle:(NSString *)title Content:(NSString *)content
{
    self = [super init];
    if (self) {
        _title = title;
        _content = content;
    }
    return self;
}
+ (instancetype)displayModelWithTitle:(NSString *)title Content:(NSString *)content
{
    return [[self alloc]initWithTitle:title Content:content];
}
@end
