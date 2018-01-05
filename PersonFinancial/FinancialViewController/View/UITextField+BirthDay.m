//
//  UITextField+BirthDay.m
//  UITextField输入生日
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 Lucyf. All rights reserved.
//

#import "UITextField+BirthDay.h"
#import <objc/runtime.h>

static const char *datePickerKey = '\0';

@implementation UITextField (BirthDay)
- (void)setBirthDayEditMode
{

    self.picker  = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,200)];
    
    self.picker .datePickerMode  = UIDatePickerModeDate;
    
    [self.picker  addTarget:self action:@selector(dateChanged:)forControlEvents:UIControlEventValueChanged];
    
    UIToolbar *_accessoryView  =  [[UIToolbar alloc]initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,40)];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    _accessoryView.items =@[flex,right];
    
    self.inputView   =   self.picker ;
    
    self.inputAccessoryView = _accessoryView;

}
-(void)dateChanged:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString  * date =[dateFormat stringFromDate:sender.date];
    
    self.text  =  date;
    
}


-(void)done{
    
    [self dateChanged:self.picker];
    [self resignFirstResponder];
    
}

- (void)setPicker:(UIDatePicker *)picker
{
    objc_setAssociatedObject(self, &datePickerKey, picker, OBJC_ASSOCIATION_RETAIN);
}
- (UIDatePicker *)picker
{

    return objc_getAssociatedObject(self, &datePickerKey);

}
@end
