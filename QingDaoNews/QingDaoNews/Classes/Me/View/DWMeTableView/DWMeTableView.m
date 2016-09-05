//
//  DWMeTableView.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/3.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWMeTableView.h"
#import "DWMeListCell.h"

@interface DWMeTableView ()

@property (strong, nonatomic) DWMeListCell *meListCell;

@property (strong, nonatomic) NSArray *myListArray;

@end

@implementation DWMeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        
        return 1;
        
    }
    
    return self.myListArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DWMeListCell *cell = [[DWMeListCell alloc] init];
    
    [cell dw_CellWithTableView:tableView dataArray:self.myListArray cellForRowAtIndexPath:indexPath];
    
    return cell;
}

- (NSArray *)myListArray {
    
    if (!_myListArray) {
        
        _myListArray = [DWMeListModels meList];
        
    }
    
    return _myListArray;
}

@end
