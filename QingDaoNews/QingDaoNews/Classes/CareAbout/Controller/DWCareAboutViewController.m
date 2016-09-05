//
//  DWCareAboutViewController.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/2.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWCareAboutViewController.h"
#import "DWCareAboutNewsController.h"
#import "DWCareAboutTableView.h"
#import "DWSwipeGestures.h"

@interface DWCareAboutViewController ()<UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) DWCareAboutTableView *tableView;


@end

@implementation DWCareAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTableView];

}

- (void)loadTableView {
    
    DWCareAboutTableView *tableView = [[DWCareAboutTableView alloc] initWithFrame:DWScreen_Frame style:UITableViewStylePlain];
    
    tableView.delegate = self;
    
    [self.view addSubview:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    [self.navigationController pushViewController:[[DWCareAboutNewsController alloc] init] animated:YES];
    
}


@end
