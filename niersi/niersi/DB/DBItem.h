//
//  DBItem.h
//  niersi
//
//  Created by vanney on 2017/3/5.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DBBase.h"

@interface DBItem : DBBase

+ (instancetype)defaultManager;
- (NSMutableArray *)getAllItemsByCategoryID:(int)categoryID;
- (BOOL)insertItemWithCategoryID:(int)categoryID name:(NSString *)name size:(NSString *)size extraInfo:(NSString *)extra image:(NSString *)image andManufacturer:(NSString *)manufacturer;

@end
