//
//  DWChannelLabel.m
//  QingDaoNews
//
//  Created by dwang_sui on 16/9/1.
//  Copyright © 2016年 dwang. All rights reserved.
//

#import "DWChannelLabel.h"

@implementation DWChannelLabel

- (instancetype)init{
    if (self=[super init]) {
        self.textAlignment = NSTextAlignmentCenter;
        
        self.font = [UIFont systemFontOfSize:20];
        
        //让其可以点击
        self.userInteractionEnabled = YES;
        
        self.scale = 0;
    }
    
    return self;
}

- (void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    //设置一下,我们设置scale之后一些属性
    //设置我们颜色的渐变
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    //最小也只能缩放到原来的80%
    CGFloat minScaleRate = 0.8;
    CGFloat realScale = minScaleRate + (1 - minScaleRate) *scale; //1
    
    //设置我们的transform
    self.transform = CGAffineTransformMakeScale(realScale, realScale);
}

@end
