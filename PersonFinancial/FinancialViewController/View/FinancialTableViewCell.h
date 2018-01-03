//
//  FinancialTableViewCell.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FinancialDetail;
@interface FinancialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *customerName;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *piecise;
@property (nonatomic, strong)  FinancialDetail  *datasource;

@end
