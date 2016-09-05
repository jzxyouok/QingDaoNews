//
//  DWNewFeaturesViewController.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/1.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWNewFeaturesViewController.h"
#import "DWScrollPictures.h"
#import "DWTabBarController.h"

@interface DWNewFeaturesViewController ()<DWScrollerPictureDelegate>

@property (strong, nonatomic) DWScrollPictures *features;

@end

@implementation DWNewFeaturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.features dw_SetNewFeaturesView:self.view delegate:nil imageName:@[@"image_index_iphone6_1.jpg",@"image_index_iphone6_2.jpg",@"image_index_iphone6_3.jpg",@"image_index_iphone6_4.jpg"] pageImageView:^(UIView *pageImageView, int imageCount, int imageAllCount) {
        
        UIButton *jump = [[UIButton alloc] init];
        
        jump.x = DWScreen_Width / 2 + DWScreen_Width / 22;
        
        jump.y = DWScreen_Height / 18;
        
        [jump setBackgroundImage:[UIImage imageNamed:@"image_index_iphone6_exit"] forState:UIControlStateNormal];
        
        jump.size = jump.currentBackgroundImage.size;
        
        [jump addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
        
        [pageImageView addSubview:jump];
        
        if (imageCount == imageAllCount) {
            
            UIButton *enter = [[UIButton alloc] init];
            
            enter.y = DWScreen_Height / 7 * 6;
            
            [enter setBackgroundImage:[UIImage imageNamed:@"image_index_iphone6_start"] forState:UIControlStateNormal];
            
            enter.size = enter.currentBackgroundImage.size;
            
            enter.x = self.view.width / 2 - enter.width / 2;
            
            [enter addTarget:self action:@selector(enterClick) forControlEvents:UIControlEventTouchUpInside];
            
            [pageImageView addSubview:enter];
            
        }
        
    }];
    
    [self.features dw_removePageControl];
}

- (void)enterClick {
    
    [DWUser_Defaults setBool:YES forKey:@"lastPage"];
    
    DWTabBarController *tabbar = [[DWTabBarController alloc] init];
    
    [self presentViewController:tabbar animated:YES completion:nil];
    
    [self removeFromParentViewController];
    
}

- (void)dw_nowPageCount:(double)pageCount imageAllCount:(NSInteger)imageAllCount {
    
    if (pageCount > imageAllCount) {
        
        [self enterClick];
        
    }
    
}


- (DWScrollPictures *)features {
    
    if (!_features) {
        
        _features = [[DWScrollPictures alloc] init];
        
    }
    
    return _features;
}

@end
