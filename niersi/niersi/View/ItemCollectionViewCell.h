//
//  ItemCollectionViewCell.h
//  niersi
//
//  Created by vanney on 2017/3/1.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *itemLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (nonatomic, assign) BOOL gakkiSelected;

@end
