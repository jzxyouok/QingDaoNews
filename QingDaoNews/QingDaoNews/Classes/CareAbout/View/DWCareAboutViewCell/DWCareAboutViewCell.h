//
//  DWCareAboutViewCell.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWCareAboutDataModels.h"


@interface DWCareAboutViewCell : UITableViewCell

@property (weak, nonatomic) UIScrollView *scrollView;

@property (strong, nonatomic) DWCareAboutDataModels *careAboutDataModels;

- (instancetype) dw_CellWithTableView:(UITableView *)tableView newsDataArray:(NSMutableArray *)newsDataArray cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
