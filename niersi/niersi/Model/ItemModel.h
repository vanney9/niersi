//
//  ItemModel.h
//  niersi
//
//  Created by vanney on 2017/3/4.
//  Copyright © 2017年 vanney9. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int categoryID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *extra;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *manufacturer;

- (instancetype)initWithId:(int)id categoryID:(int)categoryID name:(NSString *)name size:(NSString *)size extra:(NSString *)extra image:(NSString *)image manufacturer:(NSString *)manufacturer;
@end
