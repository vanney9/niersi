//
//  InputTableViewCell.h
//  niersi
//
//  Created by vanney on 2017/2/23.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *topLine;

@end
