//
//  FinancialDetail.m
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/25.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import "FinancialDetail.h"

@implementation FinancialDetail


- (NSArray *)transform2DisplayArray
{
    DisplayModel *model0 = [DisplayModel displayModelWithTitle:@"产品名:" Content:_productName];
    DisplayModel *model1 = [DisplayModel displayModelWithTitle:@"产品号:" Content:_productNum];
    DisplayModel *model2 = [DisplayModel displayModelWithTitle:@"颜色:" Content:_color];
    DisplayModel *model3 = [DisplayModel displayModelWithTitle:@"件数:" Content:[NSString stringWithFormat:@"%ld",(long)_pieces]];
    DisplayModel *model4 = [DisplayModel displayModelWithTitle:@"售价:" Content:[NSString stringWithFormat:@"%.1f",_price]];
    DisplayModel *model5 = [DisplayModel displayModelWithTitle:@"进价:" Content:[NSString stringWithFormat:@"%.1f",_purchasePrice]];
    DisplayModel *model6 = [DisplayModel displayModelWithTitle:@"利润:" Content:[NSString stringWithFormat:@"%.1f",_profit]];
    DisplayModel *model7 = [DisplayModel displayModelWithTitle:@"原价:" Content:[NSString stringWithFormat:@"%.1f",_originalPrice]];
    DisplayModel *model8 = [DisplayModel displayModelWithTitle:@"顾客:" Content:_customer];
    DisplayModel *model9 = [DisplayModel displayModelWithTitle:@"时间:" Content:_time];
    DisplayModel *model10 = [DisplayModel displayModelWithTitle:@"电话:" Content:_telephonNum];
    DisplayModel *model11 = [DisplayModel displayModelWithTitle:@"地址:" Content:_address];
    DisplayModel *model12 = [DisplayModel displayModelWithTitle:@"备注:" Content:_remarks];
   // DisplayModel *model13 = [DisplayModel displayModelWithTitle:@"附件图片:" Content:_attachedPhoto];
    
    
    return @[model0,model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12];
}

- (void)changePropertyWithDisplayModel:(DisplayModel *)display
{
    if ([display.title isEqualToString:@"产品名:"]) {
        self.productName = display.content;
    }else if([display.title isEqualToString:@"产品号:"]){
        self.productNum = display.content;
    }else if([display.title isEqualToString:@"颜色:"]){
        self.color = display.content;
    }else if([display.title isEqualToString:@"件数:"]){
        self.pieces = [display.content integerValue];
    }else if([display.title isEqualToString:@"售价:"]){
        self.price = [display.content floatValue];
    }else if([display.title isEqualToString:@"进价:"]){
        self.purchasePrice = [display.content floatValue];
    }else if([display.title isEqualToString:@"利润:"]){
        self.profit = [display.content floatValue];
    }else if([display.title isEqualToString:@"原价:"]){
        self.originalPrice = [display.content floatValue];
    }else if([display.title isEqualToString:@"顾客:"]){
        self.customer = display.content;
    }else if([display.title isEqualToString:@"时间:"]){
        self.time = display.content;
    }else if([display.title isEqualToString:@"电话:"]){
        self.telephonNum = display.content;
    }else if([display.title isEqualToString:@"地址:"]){
        self.address = display.content;
    }else if([display.title isEqualToString:@"备注:"]){
        self.remarks = display.content;
    }
}









@end
