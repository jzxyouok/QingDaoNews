//
//  DWCareAboutDataModels.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DWCareAboutDataModels : NSObject

/** 当前新闻ID */
@property (assign, nonatomic) NSInteger ID;

/** 新闻标题 */
@property (copy, nonatomic) NSString *subject;

/** 所在专题 */
@property (copy, nonatomic) NSString *cate;

/** 子标题 */
@property (copy, nonatomic) NSString *memo;

/** 小图 */
@property (copy, nonatomic) NSString *img;

/** 发布时间 */
@property (copy, nonatomic) NSString *date;

/** cell类型 */
@property (copy, nonatomic) NSString *newstype;

/**  */
@property (copy, nonatomic) NSString *url;

/** 当前评论数量 */
@property (assign, nonatomic) NSInteger cnm;

/** 当前新闻图片数组 */
@property (strong, nonatomic) NSArray *imgs;

@end
