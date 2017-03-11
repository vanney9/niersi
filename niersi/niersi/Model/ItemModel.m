//
//  ItemModel.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

- (instancetype)initWithId:(int)id1 categoryID:(int)categoryID name:(NSString *)name size:(NSString *)size extra:(NSString *)extra image:(NSString *)image manufacturer:(NSString *)manufacturer {
    if (self = [super init]) {
        _id = id1;
        _categoryID = categoryID;
        _name = name;
        _size = size;
        _extra = extra;
        _image = image;
        _manufacturer = manufacturer;
    }

    return self;
}


@end
