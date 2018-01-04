//
//  DataBase.h
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FinancialDetail.h"
#define dbKey_productName         @"productName"
#define dbKey_productNum          @"productNum"
#define dbKey_color               @"color"
#define dbKey_pieces              @"pieces"
#define dbKey_price               @"price"
#define dbKey_puchasePrice        @"puchasePrice"
#define dbKey_originalPrice       @"originalPrice"
#define dbKey_profit              @"profit"
#define dbKey_customer            @"customer"
#define dbKey_time                @"time"
#define dbKey_telePhoneNum        @"telePhoneNum"
#define dbKey_remarks             @"remarks"
#define dbKey_address             @"address"
#define dbKey_attachedPicture     @"attachedPicture"

@interface DataBase : NSObject



+ (instancetype)sharedDataBase;
- (void)addFinancial:(FinancialDetail *)financialM;
- (NSMutableArray *)getAllFinancial;
- (void)updateFinancial:(FinancialDetail *)financialM;
- (void)deleteFinancial:(FinancialDetail *)financialM;
@end
