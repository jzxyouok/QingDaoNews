//
//  DWFactModels.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/4.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DWFactModels : NSObject

/** 新闻主标题 */
@property (copy, nonatomic) NSString *subject;

/** 新闻ID */
@property (assign, nonatomic) NSInteger ID;

/** 内容主体 */
@property (copy, nonatomic) NSString *memo;

/** 配图 */
@property (copy, nonatomic) NSString *img;

/** 发布日期 */
@property (copy, nonatomic) NSString *date;

/** 显示类型 */
@property (copy, nonatomic) NSString *newstype;

/** 评论量 */
@property (assign, nonatomic) NSInteger cnm;

/** 用户名 */
@property (copy, nonatomic) NSString *username;

/** 用户头像 */
@property (copy, nonatomic) NSString *face;

/** 评论者信息 */
@property (strong, nonatomic) NSArray *comments;


@end
