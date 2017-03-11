//
//  DBCategory.h
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DBBase.h"

@interface DBCategory : DBBase

+ (instancetype)defaultManager;
- (NSMutableArray *)getAllCategories;
- (BOOL)insertCategoryWithName:(NSString *)name;

/*
 * 删除category
 */
- (BOOL)deleteCategoryWithID:(int)id;
@end
