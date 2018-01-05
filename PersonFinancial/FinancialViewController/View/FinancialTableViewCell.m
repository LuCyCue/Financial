//
//  FinancialTableViewCell.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "FinancialTableViewCell.h"
#import "FinancialDetail.h"

@implementation FinancialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDatasource:(FinancialDetail *)datasource
{
    _datasource = datasource;
    _productName.text = datasource.productName;
    _piecise.text = [NSString stringWithFormat:@"%2d 件",(int)datasource.pieces];
    _time.text = datasource.time;
    _customerName.text = datasource.customer;
    _LabProfit.text = [NSString stringWithFormat:@"%d¥",(int)datasource.profit];
}
@end
