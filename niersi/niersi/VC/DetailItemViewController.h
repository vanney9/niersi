//
//  DetailItemViewController.h
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"

typedef NS_ENUM(NSInteger, DetailItemVCType) {
    DetailItemVCTypeNotEdit = 0,
    DetailItemVCTypeEdit,
};

@interface DetailItemViewController : UIViewController
@property (nonatomic, assign) DetailItemVCType type;
@property (nonatomic, strong) ItemModel *item;
@end
