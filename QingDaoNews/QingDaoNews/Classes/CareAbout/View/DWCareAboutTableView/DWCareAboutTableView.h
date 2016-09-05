//
//  DWCareAboutTableView.h
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DWCareAboutViewCell.h"

@interface DWCareAboutTableView : UITableView<UITableViewDataSource>

@property (strong, nonatomic) DWCareAboutViewCell *careAboutViewCell;

@property (strong, nonatomic) NSMutableArray *newsDataArray;

@end
