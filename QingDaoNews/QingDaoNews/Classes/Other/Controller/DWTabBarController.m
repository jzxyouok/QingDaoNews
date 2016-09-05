//
//  DWTabBarController.m
//  QingDaoNews
//
//  Created by cdk on 16/9/1.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWTabBarController.h"
#import "MainViewController.h"
#import "DWCareAboutViewController.h"
#import "DWFactViewController.h"
#import "DWMeViewController.h"

@interface DWTabBarController ()

@end

@implementation DWTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_background"];;
    
    MainViewController *main = [[MainViewController alloc] init];
    
    main.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:main  imageName:@"tab_xinwen"];
    
    DWCareAboutViewController *careAbout = [[DWCareAboutViewController alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    careAbout.navigationItem.title = @"关心";
    
    [self addChildViewController:careAbout imageName:@"tab_guanxin"];
    
    DWFactViewController *face = [[DWFactViewController alloc] init];

    face.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:face imageName:@"tab_baoliao"];
    
    DWMeViewController *me = [[DWMeViewController alloc] init];
    
    me.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildViewController:me imageName:@"tab_wo"];

}


- (void)addChildViewController:(UIViewController *)vc imageName:(NSString *)imageName{
    
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.title = nil;
    
    vc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [vc.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    [self addChildViewController:nav];
    
}

@end
