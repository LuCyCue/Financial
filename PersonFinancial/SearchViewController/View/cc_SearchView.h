//
//  cc_SearchView.h
//  PT_DocDemo
//
//  Created by mac on 2017/12/1.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCSearchBar.h"

@protocol cc_searchViewDelegate<NSObject>
@optional
- (void)searchTextDidChange:(NSString *)text;
@required
- (void)startSearchWithText:(NSString *)text;
- (void)dismissSearchViewController;

@end

@interface cc_SearchView : UIView

@property (nonatomic, strong)    CCSearchBar    *searchBar;

@property (nonatomic, strong)    UIButton       *BtnBack;

@property (nonatomic, weak)      id<cc_searchViewDelegate>     delegate;


@end
