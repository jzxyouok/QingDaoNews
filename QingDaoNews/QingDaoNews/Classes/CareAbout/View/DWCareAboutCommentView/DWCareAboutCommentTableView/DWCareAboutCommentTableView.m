//
//  DWCareAboutCommentTableView.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/5.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWCareAboutCommentTableView.h"

@implementation DWCareAboutCommentTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    return cell;
    
}

@end
