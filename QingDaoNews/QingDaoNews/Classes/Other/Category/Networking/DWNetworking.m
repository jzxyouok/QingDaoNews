//
//  DWNetworking.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWNetworking.h"

@implementation DWNetworking

+ (void)dw_HTTPMethod:(NSString * _Nonnull)requestMethod urlString:(NSString * _Nonnull)urlString completionHandler:(void (^ _Nullable )(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler JSONData:(void (^ _Nullable) (NSDictionary * _Nonnull jsonData))jsonData {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    [request setHTTPMethod:requestMethod];
    
    [request setValue:@"UTF-8" forHTTPHeaderField:@"charset"];
    
    NSURLSessionDataTask * dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        completionHandler(data, response, error);
        
        if (data.length) {
            
            NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
               jsonData(dataDict); 
                
            });
            
        }
        
    }];
    
    [dataTask resume];

    
}


@end
