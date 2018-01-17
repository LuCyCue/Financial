//
//  NetWorkApi.h
//  PersonFinancial
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FinancialDetail;

typedef  void(^NetBoolResultBlock)(BOOL isSuccess, NSError *error);
typedef  void(^NetStringResultBlock)(BOOL isSuccess, NSString *objectId, NSError *error);
typedef void(^NetArrayResultBlock)(BOOL isSuccess, NSArray *array);


@interface NetWorkApi : NSObject

kGCD_SHAREINSTANCE_HEADER(NetWorkApi)

+ (void)ApiRegister;


+ (void)addFinancial:(FinancialDetail *)financialM   Result:(NetStringResultBlock)callBack;

+ (void)deleteFinancial:(FinancialDetail *)financialM  Result:(NetBoolResultBlock)callBack;

+ (void)updateFinancial:(FinancialDetail *)financialM  Result:(NetBoolResultBlock)callBack;

+ (void)getAllFinancialFromServer:(NetArrayResultBlock)callBack;


@end
