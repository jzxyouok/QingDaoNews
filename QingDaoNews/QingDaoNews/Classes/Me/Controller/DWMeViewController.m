//
//  DWMeViewController.m
//  QingDaoNews
//
//  Created by cdk on 16/9/1.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWMeViewController.h"
#import "DWMeTableView.h"

@interface DWMeViewController ()<UITableViewDelegate>

@end

@implementation DWMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self loadMeTableView];
    
}

- (void)loadMeTableView {
    
    DWMeTableView *tableView = [[DWMeTableView alloc] initWithFrame:CGRectMake(0, -22, DWScreen_Width, DWScreen_Height + 22) style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    if (section == 0) {
        
        return 0.1;
        
    }
    
    return 3;
    
}


@end
