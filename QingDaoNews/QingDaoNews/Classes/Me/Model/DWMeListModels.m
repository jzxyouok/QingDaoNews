//
//  DWMeListModels.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/3.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWMeListModels.h"

@implementation DWMeListModels

- (instancetype) initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

+ (instancetype) meListWithDict:(NSDictionary *)dict {
    
    return [[self alloc]initWithDict:dict];
    
}

+ (NSArray *) meList {
    
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Me" ofType:@"plist"]];
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    
    for (NSDictionary *dict in array) {
        
        DWMeListModels *meList = [DWMeListModels meListWithDict:dict];
        
        [arrayM addObject:meList];
        
    }
    
    return arrayM;
    
}


@end
