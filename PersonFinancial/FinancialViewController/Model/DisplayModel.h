//
//  DisplayModel.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/27.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayModel : NSObject

@property (nonatomic, strong)   NSString  *title;

@property (nonatomic, strong)   NSString  *content;

+ (instancetype)displayModelWithTitle:(NSString *)title Content:(NSString *)content;

@end
