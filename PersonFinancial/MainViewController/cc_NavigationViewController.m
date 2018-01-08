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
                                               NSFontAttributeName:[UIFont fontWithName:@"CourierNewPS-BoldMT" size:20]
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
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [btn setTitle:@"返回" forState:UIControlStateNormal];
        [btn setTitle:@"返回" forState:UIControlStateHighlighted];
        // 调整content的内容边距, 这样可以让btn看上去左移了
        // 这样调整后的按钮外部的内容是可以点击的
        // 调整为-11的原因是, 开始我们的按钮距离左边的距离是16, 这样可以让按钮看上去距离左边为5
        btn.contentEdgeInsets = UIEdgeInsetsMake(0, -11, 0, 0);
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)goBack
{
    [self popViewControllerAnimated:YES];
}
@end
