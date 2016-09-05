//
//  DWMeListModels.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/3.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWMeListModels : NSObject

@property (copy, nonatomic) NSString *function;

@property (copy, nonatomic) NSString *icon;

@property (copy, nonatomic) NSString *message;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) meListWithDict:(NSDictionary *)dict;

+ (NSArray *) meList;



@end
