//
//  DWFactTableView.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/4.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWFactTableView.h"

@implementation DWFactTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        
        
        
        //下拉刷新
        self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
                  }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.mj_header.automaticallyChangeAlpha = YES;
        
        // 上拉刷新
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            
            
        }];
        
    }
    return self;
}

@end
