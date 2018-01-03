//
//  UITextField+BirthDay.h
//  UITextField输入生日
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 Lucyf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (BirthDay)

@property (nonatomic, strong)     UIDatePicker     *picker;

- (void)setBirthDayEditMode;

@end
