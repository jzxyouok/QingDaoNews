//
//  DWCareAboutTableView.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWCareAboutTableView.h"
#import "DWCareAboutDataModels.h"

@interface DWCareAboutTableView ()

@property (assign, nonatomic) NSInteger ID;

@end

@implementation DWCareAboutTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        
        __unsafe_unretained __typeof(self) weekSelf = self;
        
        //下拉刷新
        self.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            DWCareAboutDataModels *fistCareAboutDataModels = self.newsDataArray.firstObject;
            
            self.ID = fistCareAboutDataModels.ID;
            
            [weekSelf loadNewsDataurlString:@"http://app.qingdaonews.com/shoujikehuduan/mdi_newslist300.php?type=guanxin&num=20&v=2.0" refreshType:@"header"];
            
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.mj_header.automaticallyChangeAlpha = YES;
        
        // 上拉刷新
        self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
            DWCareAboutDataModels *lastCareAboutDataModels = self.newsDataArray.lastObject;
            
                if (self.newsDataArray.count > 40) {
                    
                    for (int i = 0; i < self.newsDataArray.count / 2; i ++) {
                        
                        [self.newsDataArray removeObjectAtIndex:i];
                        
                    }
                    
                }
            
            [weekSelf loadNewsDataurlString:[NSString stringWithFormat:@"http://app.qingdaonews.com/shoujikehuduan/mdi_newslist300.php?num=20&type=guanxin&minid=%ld&v=2.0",(long)lastCareAboutDataModels.ID] refreshType:@"footer"];
            
        }];
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.newsDataArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DWCareAboutViewCell *careAboutViewCell = [[DWCareAboutViewCell alloc] init];
    
    self.careAboutViewCell = careAboutViewCell;
    
    [careAboutViewCell dw_CellWithTableView:tableView newsDataArray:self.newsDataArray cellForRowAtIndexPath:indexPath];
    
    return careAboutViewCell;
}


- (NSMutableArray *)newsDataArray {
    
    if (!_newsDataArray) {
        
        _newsDataArray = [NSMutableArray array];
        
        [self loadNewsDataurlString:@"http://app.qingdaonews.com/shoujikehuduan/mdi_newslist300.php?type=guanxin&num=20&v=2.0" refreshType:@"header"];
        
    }
    
    return _newsDataArray;
}

- (void)loadNewsDataurlString:(NSString *)urlString refreshType:(NSString *)refreshType{
    
    [DWNetworking dw_HTTPMethod:@"GET" urlString:urlString completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    } JSONData:^(NSDictionary * _Nonnull jsonData) {
        
        if ([refreshType isEqualToString:@"header"]) {
            
            self.newsDataArray = [DWCareAboutDataModels mj_objectArrayWithKeyValuesArray:[jsonData objectForKey:@"data"]];
            
            [self reloadData];
            
             [self.mj_header endRefreshing];
        }
    
        if ([refreshType isEqualToString:@"footer"]) {
        
            @try {
                
                [self.newsDataArray addObjectsFromArray:[DWCareAboutDataModels mj_objectArrayWithKeyValuesArray:[jsonData objectForKey:@"data"]]];
                
                [self reloadData];
            }
            @catch (NSException *exception) {
                // 捕获到的异常exception
                DWLog(@"%@",exception);
                
            }
            @finally {
                
                [self.mj_footer endRefreshing];
                
            }
            
       
        
        }
       
        
    }];
    
}

@end
