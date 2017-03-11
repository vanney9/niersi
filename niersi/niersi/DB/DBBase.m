//
//  DBBase.m
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import "DBBase.h"

#define DB_NAME @"niersi.sqlite"
#define PWD_STRUCTURE @"CREATE TABLE IF NOT EXISTS 'PWD' ('username' VARCHAR(64), 'password' VARCHAR(64))"
#define CATEGORY_STRUCTURE @"CREATE TABLE IF NOT EXISTS 'Category' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'name' TEXT)"
#define ITEM_STRUCTURE @"CREATE TABLE IF NOT EXISTS 'Item' ('id' INTEGER PRIMARY KEY AUTOINCREMENT, 'category_id' INTEGER, 'name' TEXT, 'size' TEXT, 'extra' TEXT, 'image' TEXT, 'manufacturer' TEXT)"

@implementation DBBase

- (instancetype)init {
    if (self = [super init]) {
        _db = [[self class] getDataBase];
        [[self class] createDBTables];
    }

    return self;
}

+ (void)createDBTables {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        BOOL table1, table2, table3;
        FMDatabase *db = [self getDataBase];
        [db open];
        table1 = [db executeUpdate:PWD_STRUCTURE];
        table2 = [db executeUpdate:CATEGORY_STRUCTURE];
        table3 = [db executeUpdate:ITEM_STRUCTURE];

        if (table1 && table2 && table3) {

        } else {
            NSLog(@"vanney code log : create db table error : %@", [db lastErrorMessage]);
            exit(1);
        }
        [db close];
    });
}

+ (FMDatabase *)getDataBase {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@", [paths firstObject], DB_NAME];
    NSLog(@"vanney code log : db path is %@", dbPath);
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    return db;
}

@end
