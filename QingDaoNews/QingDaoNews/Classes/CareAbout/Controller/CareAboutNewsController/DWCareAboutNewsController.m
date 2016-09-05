//
//  DWCareAboutNewsController.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/4.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWCareAboutNewsController.h"

@interface DWCareAboutNewsController ()

@end

@implementation DWCareAboutNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navbar_button_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];

    self.navigationItem.leftBarButtonItem = backItem;
    
    UIBarButtonItem *commentsNum = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navbar_button_comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(commentsNumClick)];
    
    self.navigationItem.rightBarButtonItem = commentsNum;
    
}

- (void)backClick {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)commentsNumClick {
    
    
    
}

@end
