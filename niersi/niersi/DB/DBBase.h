//
//  DBBase.h
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

typedef NS_ENUM(NSInteger, DBTableType) {
    DBTableTypePWD = 0,
    DBTableTypeCategory,
    DBTableTypeItem,
};

@interface DBBase : NSObject
@property (nonatomic, strong) FMDatabase *db;



@end
