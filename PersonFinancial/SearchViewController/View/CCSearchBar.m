//
//  CCSearchBar.m
//  FZD_UIKit
//
//  Created by mac on 2017/11/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "CCSearchBar.h"

@implementation CCSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.bounds = CGRectMake(0, 0, 300, 300);
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询内容";
        self.borderStyle = UITextBorderStyleRoundedRect;
        // 提前在Xcode上设置图片中间拉伸
       // self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
        searchIcon.bounds = CGRectMake(0, 0, 30, 30);
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.returnKeyType = UIReturnKeySearch;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}


@end
