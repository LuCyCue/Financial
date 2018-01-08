//
//  cc_SearchView.m
//  PT_DocDemo
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "cc_SearchView.h"
@interface cc_SearchView()<UITextFieldDelegate>

@property (nonatomic, assign)    BOOL  isNeedStarSearch;

@end

@implementation cc_SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect sFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    self = [super initWithFrame:sFrame];
    if (self) {
        _BtnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        [_BtnBack setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [_BtnBack setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [_BtnBack addTarget:self action:@selector(turnBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_BtnBack];
        
        _searchBar = [[CCSearchBar alloc]init];
        _searchBar.delegate = self;
        [_searchBar addTarget:self action:@selector(searchTextDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_searchBar];
        
        _isNeedStarSearch = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _BtnBack.frame = CGRectMake(10, 28, 40, 30);
    _BtnBack.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    _searchBar.frame = CGRectMake(50.f, 28.f, [UIScreen mainScreen].bounds.size.width - 80.f, 30);
}
- (void)turnBack
{
    _isNeedStarSearch = NO;
    [self.searchBar resignFirstResponder];
    [self.delegate dismissSearchViewController];
}
#pragma mark --UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    [_searchBar resignFirstResponder];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //清除不必要的回调
    if (_isNeedStarSearch && textField.text.length > 0) {
        [self.delegate startSearchWithText:textField.text];
    }
}
- (void)searchTextDidChange:(UITextField *)sender
{
    if ([self.delegate respondsToSelector:@selector(searchTextDidChange:)]) {
        [self.delegate searchTextDidChange:sender.text];
    }
}
@end










