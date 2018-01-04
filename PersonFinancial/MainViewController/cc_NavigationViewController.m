//
//  cc_NavigationViewController.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2018/1/3.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "cc_NavigationViewController.h"

@interface cc_NavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation cc_NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetNavi];
    self.delegate = self;
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                               NSFontAttributeName:[UIFont fontWithName:@"CourierNewPS-ItalicMT" size:20]
                                               };
}
/**
 导航栏
 */
- (void)resetNavi
{
    //
    //
    
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
