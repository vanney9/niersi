//
//  ItemCollectionViewCell.m
//  niersi
//
//  Created by vanney on 2017/3/1.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "ItemCollectionViewCell.h"


@implementation ItemCollectionViewCell

@synthesize gakkiSelected = _gakkiSelected;

- (void)setGakkiSelected:(BOOL)gakkiSelected {
    NSLog(@"vanney code log : what happened");
    _gakkiSelected = gakkiSelected;
    if (_gakkiSelected) {
        _maskView.hidden = NO;
        _deleteButton.hidden = NO;
    } else {
        _maskView.hidden = YES;
        _deleteButton.hidden = YES;
    }
}

- (BOOL)gakkiSelected {
    return _gakkiSelected;
}

@end
