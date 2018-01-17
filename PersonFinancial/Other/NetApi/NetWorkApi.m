//
//  NetWorkApi.m
//  PersonFinancial
//
//  Created by mac on 2018/1/17.
//  Copyright © 2018年 Chengchang Lu. All rights reserved.
//

#import "NetWorkApi.h"
#import <BmobSDK/Bmob.h>
#import "FinancialDetail.h"
#import "DataBase.h"

#define NetTableName   @"t_NetFinancial"
@implementation NetWorkApi

kGCD_SHAREINSTANCE_CLASS(NetWorkApi)

+ (void)ApiRegister
{
    [Bmob registerWithAppKey:@"79256a68cb937f0149065ee27e832eb0"];
}

+ (void)addFinancial:(FinancialDetail *)financialM   Result:(NetStringResultBlock)callBack
{
    NSDictionary *dic = [financialM transToDict];
    __block BmobObject *financialTable = [BmobObject objectWithClassName:NetTableName];
    [financialTable saveAllWithDictionary:dic];
    [financialTable saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        callBack(isSuccessful, financialTable.objectId,error);
    }];
}

+ (void)deleteFinancial:(FinancialDetail *)financialM  Result:(NetBoolResultBlock)callBack
{
    BmobQuery *bquery = [BmobQuery queryWithClassName:NetTableName];
    [bquery getObjectInBackgroundWithId:financialM.objectId block:^(BmobObject *object, NSError *error){
        if (error) {
            //进行错误处理
            callBack(NO,error);
        }
        else{
            if (object) {
                //异步删除object
                [object deleteInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
                    callBack(isSuccessful,error);
                }];
            }
        }
    }];
}

+ (void)updateFinancial:(FinancialDetail *)financialM  Result:(NetBoolResultBlock)callBack
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:NetTableName];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:financialM.objectId block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                BmobObject *obj1 = [BmobObject objectWithoutDataWithClassName:object.className objectId:object.objectId];
                //设置cheatMode为YES
                NSDictionary *dic = [financialM transToDict];
                [obj1 saveAllWithDictionary:dic];
                //异步更新数据
                [obj1 updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    callBack(isSuccessful,error);
                }];
            }else{
                callBack(NO,error);
            }
        }else{
            //进行错误处理
            callBack(NO,error);
        }
    }];
}

+ (void)getAllFinancialFromServer:(NetArrayResultBlock)callBack
{
    BmobQuery   *bquery = [BmobQuery queryWithClassName:NetTableName];
    //查找GameScore表的数据
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (!error) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (BmobObject *obj in array) {
                FinancialDetail *financialM = [FinancialDetail new];
                financialM.objectId = [obj objectId];
                financialM.ID = [[obj objectForKey:@"ID"] integerValue];
                financialM.productName = [obj objectForKey:dbKey_productName];
                financialM.productNum = [obj objectForKey:dbKey_productNum];
                financialM.color = [obj objectForKey:dbKey_color];
                financialM.price = [[obj objectForKey:dbKey_price] floatValue];
                financialM.purchasePrice = [[obj objectForKey:dbKey_puchasePrice] floatValue];
                financialM.pieces = [[obj objectForKey:dbKey_pieces] integerValue];
                financialM.profit = [[obj objectForKey:dbKey_profit] floatValue];
                financialM.originalPrice = [[obj objectForKey:dbKey_originalPrice] floatValue];
                financialM.time = [obj objectForKey:dbKey_time];
                financialM.telephonNum = [obj objectForKey:dbKey_telePhoneNum];
                financialM.address = [obj objectForKey:dbKey_address];
                financialM.remarks = [obj objectForKey:dbKey_remarks];
                financialM.customer = [obj objectForKey:dbKey_customer];
                [resultArray addObject:financialM];
            }
            callBack(YES,resultArray);
        }else{
            callBack(NO, nil);
        }
      
    }];
}


@end


