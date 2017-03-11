//
//  DBCategory.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DBCategory.h"
#import "CategoryModel.h"

#define kTableName @"Category"

@implementation DBCategory

static DBCategory *_instance = nil;

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DBCategory alloc] init];
        [_instance.db open];
    });

    return _instance;
}

- (NSMutableArray *)getAllCategories {
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", kTableName];
    FMResultSet *resultSet = [self.db executeQuery:sql];
    NSMutableArray *resultArray = [NSMutableArray new];
    while ([resultSet next]) {
        int curId = [resultSet intForColumn:@"id"];
        NSString *curName = [resultSet stringForColumn:@"name"];
        CategoryModel *curCategory = [[CategoryModel alloc] initWithId:curId andName:curName];
        [resultArray addObject:curCategory];
    }

    return resultArray;
}

- (BOOL)insertCategoryWithName:(NSString *)name {
    NSLog(@"vanney code log : insert db with name %@", name);
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (name) VALUES ('%@')", kTableName, name];
    BOOL result = [self.db executeUpdate:sql];
    if (!sql) {
        NSLog(@"vanney code log : %@", [self.db lastErrorMessage]);
    }

    return result;
}

- (BOOL)deleteCategoryWithID:(int)id1 {
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %d", kTableName, id1];
    BOOL result = [self.db executeUpdate:sql];
    if (!result) {
        NSLog(@"vanney code log : %@", [self.db lastErrorMessage]);
    }

    return result;
}


@end
