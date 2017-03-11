//
//  DBItem.m
//  niersi
//
//  Created by vanney on 2017/3/5.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DBItem.h"
#import "ItemModel.h"

#define kCategoryTable @"Category"
#define kItemTable @"Item"

@implementation DBItem

static DBItem *_instance = nil;

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DBItem alloc] init];
        [_instance.db open];
    });

    return _instance;
}

- (NSMutableArray *)getAllItemsByCategoryID:(int)categoryID {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ where category_id = %d", kItemTable, categoryID];
    FMResultSet *resultSet = [self.db executeQuery:sql];
    NSMutableArray *resultArray = [NSMutableArray new];
    while ([resultSet next]) {
        int id = [resultSet intForColumn:@"id"];
        int categoryID = [resultSet intForColumn:@"category_id"];
        NSString *name = [resultSet stringForColumn:@"name"];
        NSString *size = [resultSet stringForColumn:@"size"];
        NSString *extra = [resultSet stringForColumn:@"extra"];
        NSString *image = [resultSet stringForColumn:@"image"];
        NSString *manufacturer = [resultSet stringForColumn:@"manufacturer"];

        ItemModel *curModel = [[ItemModel alloc] initWithId:id categoryID:categoryID name:name size:size extra:extra image:image manufacturer:manufacturer];
        [resultArray addObject:curModel];
    }

    return resultArray;
}

- (BOOL)insertItemWithCategoryID:(int)categoryID name:(NSString *)name size:(NSString *)size extraInfo:(NSString *)extra image:(NSString *)image andManufacturer:(NSString *)manufacturer {
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (category_id, name, size, extra, image, manufacturer) VALUES (%d, '%@', '%@', '%@', '%@', '%@')", kItemTable, categoryID, name, size, extra, image, manufacturer];
    BOOL result = [self.db executeUpdate:sql];
    if (!result) {
        NSLog(@"vanney code log : %@", [self.db lastErrorMessage]);
        exit(1);
    }

    return result;
}


@end
