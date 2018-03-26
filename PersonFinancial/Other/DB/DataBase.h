//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinancialDetail.h"
#import "OverViewModel.h"

#define dbKey_productName         @"productName"
#define dbKey_productNum          @"productNum"
#define dbKey_color               @"color"
#define dbKey_pieces              @"pieces"
#define dbKey_price               @"price"
#define dbKey_puchasePrice        @"purchasePrice"
#define dbKey_originalPrice       @"originalPrice" 
#define dbKey_profit              @"profit"
#define dbKey_customer            @"customer"
#define dbKey_time                @"time"
#define dbKey_telePhoneNum        @"telephonNum"
#define dbKey_remarks             @"remarks"
#define dbKey_address             @"address"
#define dbKey_attachedPicture     @"attachedPicture"
#define dbKey_objectId            @"objectId"
#define dbKey_size                @"size"

@interface DataBase : NSObject



+ (instancetype)sharedDataBase;

//add
- (void)addFinancial:(FinancialDetail *)financialM;
- (void)addFinancialsWithArray:(NSArray *)array;
//update
- (void)updateFinancial:(FinancialDetail *)financialM;

//delete
- (void)deleteFinancial:(FinancialDetail *)financialM;
- (void)truncateTable;

//select
- (NSMutableArray *)getAllFinancial;
- (OverViewModel *)getOverViewMessageWithStartTime:(NSString *)startTime EndTime:(NSString *)endTime CutomerName:(NSString *)cutomer;
- (NSMutableArray *)getFinancialWithText:(NSString *)searchText;
- (NSString *)getMinTime;
- (NSString *)getMaxTime;
- (NSMutableArray *)getFinancialWithStartTime:(NSString *)startTime EndTime:(NSString *)endTime CutomerName:(NSString *)cutomer;
- (NSMutableArray *)getAllCutomer;
- (NSInteger)getMaxId;

@end
