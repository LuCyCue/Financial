//
//  RemaksCell.h
//  PersonFinancial
//
//  Created by Chengchang Lu on 2017/12/28.
//  Copyright © 2017年 Chengchang Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^contenDidChangeBlock) (NSString *title,NSString *content);


@interface RemaksCell : UITableViewCell<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UILabel *LabTitle;

@property (weak, nonatomic) IBOutlet UITextView *TexContent;

@property (nonatomic, copy)    contenDidChangeBlock contenDidChange;

@end
