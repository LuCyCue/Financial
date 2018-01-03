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
    
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    // 文件路径
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"financial.sqlite"];
    
    // 实例化FMDataBase对象
    
    _db = [FMDatabase databaseWithPath:filePath];
    
    [_db open];
    
    // 初始化数据表
    
    NSString *FinancialSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 't_financial' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL ,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' INTEGER,'%@' REAL,'%@' REAL,'%@' REAL,'%@' REAL,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' TEXT,'%@' BLOB )",dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture];
    [_db executeUpdate:FinancialSql];
    
    
    [_db close];

}
#pragma mark --Financial Methods
- (void)addFinancial:(FinancialDetail *)financialM
{
    [_db open];
    
    NSData *imageData = UIImagePNGRepresentation(financialM.attachedPhoto);
    NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO t_financial (%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture];
    [_db executeUpdate:sqlStr,financialM.productName,financialM.productNum,financialM.color,@(financialM.pieces),@(financialM.price),@(financialM.purchasePrice),@(financialM.originalPrice),@(financialM.profit),financialM.customer,financialM.time,financialM.telephonNum,financialM.address,financialM.remarks,imageData];
    
    [_db close];
}

- (void)updateFinancial:(FinancialDetail *)financialM
{
    [_db open];
    
    NSData *imageData = UIImagePNGRepresentation(financialM.attachedPhoto);
    NSString *sqlStr = [NSString stringWithFormat:@"UPDATE t_financial SET %@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=?,%@=? WHERE id=?",dbKey_productName,dbKey_productNum,dbKey_color,dbKey_pieces,dbKey_price,dbKey_puchasePrice,dbKey_originalPrice,dbKey_profit,dbKey_customer,dbKey_time,dbKey_telePhoneNum,dbKey_address,dbKey_remarks,dbKey_attachedPicture];
    [_db executeUpdate:sqlStr,financialM.productName,financialM.productNum,financialM.color,@(financialM.pieces),@(financialM.price),@(financialM.purchasePrice),@(financialM.originalPrice),@(financialM.profit),financialM.customer,financialM.time,financialM.telephonNum,financialM.address,financialM.remarks,imageData,@(financialM.ID)];
    
    [_db close];
    
}

- (NSMutableArray *)getAllFinancial
{
    [_db open];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    
    FMResultSet *res = [_db executeQuery:@"SELECT * FROM t_financial ORDER BY time DESC"];
    
    while ([res next]) {
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
        [dataArray addObject:financialM];
        
    }
    
    [_db close];
    
    
    
    return dataArray;
    
    
}







@end
