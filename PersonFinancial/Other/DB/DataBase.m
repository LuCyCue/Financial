//
//  DataBase.m
//  FMDBDemo
//
//  Created by Zeno on 16/5/18.
//  Copyright © 2016年 zenoV. All rights reserved.
//

#import "DataBase.h"
#import <FMDB.h>


static DataBase *_DBCtl = nil;

@interface DataBase()<NSCopying,NSMutableCopying>{
    FMDatabase  *_db;
    
}




@end

@implementation DataBase

+(instancetype)sharedDataBase{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [[DataBase alloc] init];
        
        [_DBCtl initDataBase];
        
    }
    
    return _DBCtl;
    
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (_DBCtl == nil) {
        
        _DBCtl = [super allocWithZone:zone];
        
    }
    
    return _DBCtl;
    
}

-(id)copy{
    
    return self;
    
}

-(id)mutableCopy{
    
    return self;
    
}

-(id)copyWithZone:(NSZone *)zone{
    
    return self;
    
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    
    return self;
    
}


-(void)initDataBase{
    // 获得Documents目录路径
    
    NSString *documentsPath = kDocumentPath;
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"financial.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    
    NSString *FinancialSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 't_financial' ('id' INTEGER PRIMARY KEY   NOT NULL ,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' INTEGER,'%@' REAL,'%@' REAL,'%@' REAL,'%@' REAL,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' BLOB )",dbKey_objectId,dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture];
    [_db executeUpdate:FinancialSql];
    
    if (![_db columnExists:dbKey_size inTableWithName:@"t_financial"]){
        NSString *alertStr = [NSString stringWithFormat:@"ALTER TABLE t_financial ADD %@ TEXT",dbKey_size];
        BOOL worked = [_db executeUpdate:alertStr];
        if(worked){
            NSLog(@"插入成功");
        }else{
            NSLog(@"插入失败");
        }
    }
    [_db close];

}
#pragma mark --Financial Methods
- (void)addFinancial:(FinancialDetail *)financialM
{
    [_db open];
    
    NSData *imageData = UIImagePNGRepresentation(financialM.attachedPhoto);
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO t_financial (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",@"id",dbKey_objectId,dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture,dbKey_size];
    [_db executeUpdate:sqlStr,@(financialM.ID),financialM.objectId,financialM.productName,financialM.productNum,financialM.color,@(financialM.pieces),@(financialM.price),@(financialM.purchasePrice),@(financialM.originalPrice),@(financialM.profit),financialM.customer,financialM.time,financialM.telephonNum,financialM.address,financialM.remarks,imageData,financialM.size];
    
    [_db close];
}
- (void)addFinancialsWithArray:(NSArray *)array
{
    for (FinancialDetail *financialM in array) {
        [self addFinancial:financialM];
    }
}

- (void)deleteFinancial:(FinancialDetail *)financialM
{
    [_db open];
    [_db executeUpdate:@"DELETE FROM t_financial WHERE id = ? ",@(financialM.ID)];
    [_db close];
}

/**
 清空表
 */
- (void)truncateTable
{
    [_db open];
    [_db executeUpdate:@"DELETE FROM t_financial"];
    [_db close];
}



- (void)updateFinancial:(FinancialDetail *)financialM
{
    [_db open];
    
    NSData *imageData = UIImagePNGRepresentation(financialM.attachedPhoto);
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE t_financial SET %@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=? WHERE id=?",dbKey_objectId,dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture,dbKey_size];
    [_db executeUpdate:sqlStr,financialM.objectId,financialM.productName,financialM.productNum,financialM.color,@(financialM.pieces),@(financialM.price),@(financialM.purchasePrice),@(financialM.originalPrice),@(financialM.profit),financialM.customer,financialM.time,financialM.telephonNum,financialM.address,financialM.remarks,imageData,financialM.size,@(financialM.ID)];
    
    [_db close];
    
}

- (NSMutableArray *)getAllFinancial
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM t_financial ORDER BY time DESC"];
    
    while ([res next]) {
        FinancialDetail *financialM = [self FMResultTransform2Model:res];
        [dataArray addObject:financialM];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}

- (OverViewModel *)getOverViewMessageWithStartTime:(NSString *)startTime EndTime:(NSString *)endTime CutomerName:(NSString *)customer
{
    OverViewModel *overViewM = [OverViewModel new];
    NSMutableArray *allFinancial = [self getFinancialWithStartTime:startTime EndTime:endTime CutomerName:customer];
    double expenses = 0,income = 0,profit = 0;
    for (FinancialDetail *financialM in allFinancial) {
        expenses += financialM.purchasePrice * financialM.pieces;
        income += financialM.price * financialM.pieces;
        profit += financialM.profit;
    }
    overViewM.totalExpenses = [NSString stringWithFormat:@"%.1f ￥",expenses];
    overViewM.totalIncome = [NSString stringWithFormat:@"%.1f ￥",income];
    overViewM.netProfit = [NSString stringWithFormat:@"%.1f ￥",profit];
    overViewM.startTime = startTime;
    overViewM.endTime = endTime;
    overViewM.customer = customer;
    return overViewM;
}

- (NSMutableArray *)getFinancialWithText:(NSString *)searchText
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_financial WHERE %@ LIKE '%%%@%%' OR %@ LIKE '%%%@%%' OR %@ LIKE '%%%@%%' OR %@ LIKE '%%%@%%' OR %@ LIKE '%%%@%%' OR %@ LIKE '%%%@%%' ORDER BY time DESC",dbKey_customer, searchText,dbKey_productNum, searchText,dbKey_productName,searchText,dbKey_time,searchText,dbKey_remarks,searchText,dbKey_address,searchText];
    FMResultSet *res = [_db executeQuery:sql];
    
    while ([res next]) {
        FinancialDetail *financialM = [self FMResultTransform2Model:res];
        [dataArray addObject:financialM];
    }
    
    [_db close];
    
    
    
    return dataArray;
    
}
- (NSMutableArray *)getFinancialWithStartTime:(NSString *)startTime EndTime:(NSString *)endTime CutomerName:(NSString *)customer
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *sql = nil;
    if ([customer isEqualToString:@"全部"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_financial WHERE %@ <= '%@' AND %@ >= '%@'",dbKey_time,endTime,dbKey_time,startTime];
    }else{
        sql = [NSString stringWithFormat:@"SELECT * FROM t_financial WHERE %@ LIKE '%@' AND %@ <= '%@' AND %@ >= '%@'",dbKey_customer, customer,dbKey_time,endTime,dbKey_time,startTime];
    }

    FMResultSet *res = [_db executeQuery:sql];
    
    while ([res next]) {
        FinancialDetail *financialM = [self FMResultTransform2Model:res];
        [dataArray addObject:financialM];
        
    }
    
    [_db close];
    return dataArray;
    
}
- (NSMutableArray *)getAllCutomer
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT %@ FROM t_financial",dbKey_customer];;
  
    FMResultSet *res = [_db executeQuery:sql];
    
    while ([res next]) {
        NSString *customerName = [res stringForColumn:dbKey_customer];
        [dataArray addObject:customerName];
        
    }
    [_db close];
    return dataArray;
}
- (NSString *)getMinTime
{
    [_db open];
    NSString *minTime = @"";
    NSString *sql = [NSString stringWithFormat:@"SELECT MIN(%@) FROM t_financial",dbKey_time];
    minTime = [_db stringForQuery:sql];
    if(kStringIsEmpty(minTime)){
        minTime = @"2018-01-01";
    }
   
    [_db close];
    return minTime;
}

- (NSString *)getMaxTime
{
    [_db open];
    NSString *maxTime = @"";
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(%@) FROM t_financial",dbKey_time];
    maxTime = [_db stringForQuery:sql];
    if(kStringIsEmpty(maxTime)){
        maxTime = @"2018-01-01";
    }
    
    [_db close];
    return maxTime;
}
- (NSInteger)getMaxId
{
    [_db open];
    NSInteger max = 0;
    NSString *sql = [NSString stringWithFormat:@"SELECT MAX(id) FROM t_financial"];
    max = [_db intForQuery:sql];
    [_db close];
    return max;
}

#pragma mark --Other Methods

- (FinancialDetail *)FMResultTransform2Model:(FMResultSet*)res
{
    FinancialDetail *financialM = [[FinancialDetail alloc] init];
    financialM.ID = [res intForColumn:@"id"];
    financialM.productName = [res stringForColumn:dbKey_productName];
    financialM.productNum = [res stringForColumn:dbKey_productNum];
    financialM.color =  [res stringForColumn:dbKey_color];
    financialM.pieces =  [res intForColumn:dbKey_pieces];
    financialM.price = [res doubleForColumn:dbKey_price];
    financialM.purchasePrice = [res doubleForColumn:dbKey_puchasePrice];
    financialM.originalPrice = [res doubleForColumn:dbKey_originalPrice];
    financialM.profit = [res doubleForColumn:dbKey_profit];
    financialM.customer = [res stringForColumn:dbKey_customer];
    financialM.time = [res stringForColumn:dbKey_time];
    financialM.telephonNum = [res stringForColumn:dbKey_telePhoneNum];
    financialM.address = [res stringForColumn:dbKey_address];
    financialM.remarks = [res stringForColumn:dbKey_remarks];
    financialM.attachedPhoto = [UIImage imageWithData:[res dataForColumn:dbKey_attachedPicture]];
    financialM.size = [res stringForColumn:dbKey_size];
    return financialM;
}


@end
