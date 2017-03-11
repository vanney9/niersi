//
//  CategoryModel.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (instancetype)initWithId:(int)id1 andName:(NSString *)name {
    if (self = [super init]) {
        _id = id1;
        _name = name;
    }

    return self;
}


@end
