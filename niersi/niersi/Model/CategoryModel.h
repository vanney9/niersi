//
//  CategoryModel.h
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryModel : NSObject
@property (nonatomic, assign) int id;
@property (nonatomic, strong) NSString *name;

- (instancetype)initWithId:(int)id andName:(NSString *)name;
@end
