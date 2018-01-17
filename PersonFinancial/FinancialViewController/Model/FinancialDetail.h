//
//  FinancialDetail.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/25.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DisplayModel.h"
@class UIImage;
@interface FinancialDetail : NSObject<NSCopying>

/**
 数据库中的id
 */
@property (nonatomic, assign)     NSInteger ID;
/**
 产品名
 */
@property (nonatomic, strong)     NSString  *productName;

/**
 产品号
 */
@property (nonatomic, strong)     NSString  *productNum;
/**
 客户名
 */
@property (nonatomic, strong)     NSString  *customer;
/**
 客户电话
 */
@property (nonatomic, strong)     NSString *telephonNum;
/**
 收货地址
 */
@property (nonatomic, strong)     NSString *address;
/**
 订单时间
 */
@property (nonatomic, strong)     NSString  *time;
/**
 原价
 */
@property (nonatomic, assign)     float    originalPrice;
/**
 进价
 */
@property (nonatomic, assign)     float    purchasePrice;
/**
 售价
 */
@property (nonatomic, assign)     float    price;
/**
 件数
 */
@property (nonatomic, assign)     NSInteger  pieces;
/**
 颜色
 */
@property (nonatomic, strong)     NSString *color;
/**
 利润
 */
@property (nonatomic, assign)     float   profit;
/**
 备注
 */
@property (nonatomic, strong)    NSString  *remarks;
/**
 附属照片
 */
@property (nonatomic, strong)    UIImage   *attachedPhoto;

//服务器对应id
@property (nonatomic, strong)    NSString  *objectId;



- (NSArray *)transform2DisplayArray;

- (void)changePropertyWithDisplayModel:(DisplayModel *)display;

- (NSDictionary *)transToDict;























@end
