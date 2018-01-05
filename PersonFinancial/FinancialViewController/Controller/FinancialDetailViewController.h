//
//  FinancialDetailViewController.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FinancialDetail.h"

typedef enum {
    ViewControllerModeNew,      //新创建
    ViewControllerModeEdit,     //编辑模式
    ViewControllerModeLookUp,   //查看模式
}ViewControllerMode;

@protocol FinancialChangeDelegate <NSObject>
- (void)financialDidChange;
@end
@interface FinancialDetailViewController : UIViewController

@property (nonatomic, copy)  FinancialDetail  *detailM;

@property (nonatomic, assign)   ViewControllerMode  mode;

@property (nonatomic, weak)     id<FinancialChangeDelegate>  delegate;

- (instancetype)initWithDetailM:(FinancialDetail *)detail Mode:(ViewControllerMode) mode;

@end
