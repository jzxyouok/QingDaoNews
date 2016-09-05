//
//  DWNetworking.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWNetworking : NSObject

+ (void)dw_HTTPMethod:(NSString * _Nonnull)requestMethod urlString:(NSString * _Nonnull)urlString completionHandler:(void (^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler JSONData:(void (^ _Nullable) (NSDictionary * _Nonnull jsonData))jsonData;

@end
