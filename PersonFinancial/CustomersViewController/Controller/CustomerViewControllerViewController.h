//
//  CustomerViewControllerViewController.h
//  PersonFinancial
//
//  Created by mac on 2018/1/15.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomerViewControllerViewController : UITableViewController

@property (nonatomic, copy)  void(^customerCallBack)(NSString *name);

@end
