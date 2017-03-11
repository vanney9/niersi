//
//  InputView.m
//  niersi
//
//  Created by vanney on 2017/3/5.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "InputView.h"
#import <Masonry.h>

@implementation InputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:22];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@100);
            make.height.equalTo(@64);
            make.leading.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];

        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:22];
        _textField.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3];
        [_textField setBorderStyle:UITextBorderStyleRoundedRect];
        [self addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.leading.equalTo(_label.mas_trailing).offset(15);
            make.height.equalTo(@64);
            make.trailing.equalTo(self).offset(-15);
        }];
    }

    return self;
}

@end
