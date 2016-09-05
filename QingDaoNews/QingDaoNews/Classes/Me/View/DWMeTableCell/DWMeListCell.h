//
//  DWMeListCell.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/3.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWMeListModels.h"

@interface DWMeListCell : UITableViewCell

- (instancetype) dw_CellWithTableView:(UITableView *)tableView dataArray:(NSArray *)dataArray cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
