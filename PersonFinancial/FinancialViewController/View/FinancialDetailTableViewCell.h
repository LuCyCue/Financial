//
//  FinancialDetailTableViewCell.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/28.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^contentDidChange)(NSString *title,NSString *content);
@interface FinancialDetailTableViewCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *LabTitle;
@property (weak, nonatomic) IBOutlet UITextField *TexContent;
@property (nonatomic, copy)   contentDidChange contentChange;
@property (nonatomic, assign)  BOOL isNeedInputDate;

@end
