//
//  DWNewFeatures.h
//  DWNewFeatures
//
//  Created by cdk on 16/8/2.
//  Copyright © 2016年 dwang_sui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    /** 顺时针 */
    DWFollowShuffling,
    
    /** 逆时针 */
    DWGoAgainstShuffling,
    
} DWDirection;

typedef enum :NSUInteger {
    /** 淡入淡出 */
    fade,
    
    /** 推挤 */
    push,
    
    /** 揭开 */
    reveal,
    
    /** 覆盖 */
    moveIn,
    
    /** 立方体 */
    cube,
    
    /** 吮吸 */
    suckEffect,
    
    /** 翻转 */
    oglFlip,
    
    /** 波纹 */
    rippleEffect,
    
    /** 翻页 */
    pageCurl,
    
    /** 反翻页 */
    pageUnCurl,
    
    /** 开镜头 */
    cameraIrisHollowOpen,
    
    /** 关镜头 */
    cameraIrisHollowClose,
    
    /** 下翻页 */
    curlDown,
    
    /** 上翻页 */
    curlUp,
    
    /** 左翻转 */
    flipFromLeft,
    
    /** 右翻转 */
    flipFromRight,
    
} DWAnimationType;

typedef enum :NSUInteger {
    /** 左 */
    fromLeft,
    
    /** 右 */
    fromRight,
    
    /** 上 */
    fromTop,
    
    /** 下 */
    fromBottom,
    
} DWSubtype;

@protocol DWScrollerPictureDelegate <NSObject>

@optional
/**
 *  新特性视图代理方法
 *
 *  @param pageCount  当前所在界面索引
 *  @param imageCount 新特性图片总数
 */
- (void)dw_nowPageCount:(double)pageCount imageAllCount:(NSInteger)imageAllCount;

/**
 *  获取被点击的轮播图索引
 *
 *  @param index 被点击的轮播图索引
 */
- (void)dw_ShufflingFigureSelectImageCount:(NSInteger)index;

/**
 *  获取当前轮播图所在视图
 *
 *  @param pageCount     当前所在界面
 *  @param pageViewArray 界面数组
 *  @param pageView      scrollerView
 */
- (void)dw_ShufflingFigureNowPageCount:(double)pageCount pageViewArray:(NSArray *)pageViewArray pageView:(UIView *)pageView;

@end

@interface DWScrollPictures : NSObject

/** 新特性 */
@property (assign, nonatomic) BOOL lastNews;

/** 网络图片占位图 */
@property (strong, nonatomic) UIImage *defaultImage;

/** pageController选中时的颜色 */
@property (weak, nonatomic) UIColor *pageSelctColor;

/** pageController未选中的颜色 */
@property (weak, nonatomic) UIColor *pageNormalColor;

/** direction轮播图方向/默认顺时针 */
@property (assign, nonatomic) DWDirection direction;

/** 代理 */
@property (assign, nonatomic) id <DWScrollerPictureDelegate>delegate;

/** 设置轮播图翻转样式 */
@property (assign, nonatomic) DWAnimationType animationType;

/** 设置动画的过度方向 */
@property (assign, nonatomic) DWSubtype subtype;

/** 设置动画时间 */
@property (assign, nonatomic) double duration;

/**
 *  设置引导页控制器与主页面控制器
 *
 *  @param window        主window
 *  @param newFeaturesVC 新特性控制器
 *  @param mainVC        主页控制器
 */
+ (void)dw_AppdelegateNewFeaturesWindow:(UIWindow *)window newFeaturesVC:(id)newFeaturesVC mainVC:(id)mainVC;

/**
 *  设置引导图/本地
 *
 *  @param view                          当前控制器View
 *  @param delegate                      代理遵守者
 *  @param imageNameArray                引导图数组
 *  @param pageImageView                 imageView/某个imageView/imageView总量
 */
- (void)dw_SetNewFeaturesView:(UIView *)view delegate:(id)delegate imageName:(NSArray *)imageNameArray pageImageView:(void(^) (UIView *pageImageView ,int imageCount, int imageAllCount))pageImageView;

/**
 *  设置引导图/网络
 *
 *  @param view                          当前控制器View
 *  @param delegate                      代理遵守者
 *  @param imageNameArray                引导图数组
 *  @param pageImageView                 imageView/某个imageView/imageView总量
 */
- (void)dw_SetNetworkingNewFeaturesView:(UIView *)view delegate:(id)delegate imageLinkArray:(NSArray *)imageLinkArray pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView;

/**
 *  设置本地图片轮播图
 *
 *  @param view         当前控制器View
 *  @param sizeY        轮播视图Y值
 *  @param height       轮播图高度
 *  @param pageY        pageController高度
 *  @param imageArray   轮播图数组
 *  @param timeInterval 轮播图轮播时间
 *  @param animateTimer 轮播图完成一次轮播的时间
 */
- (void)dw_SetShufflingFigureView:(UIView *)view sizeY:(CGFloat)sizeY  height:(CGFloat)height pageY:(CGFloat)pageY imageNameArray:(NSArray *)imageNameArray timeInterval:(NSTimeInterval)timeInterval animateTimer:(NSTimeInterval)animateTimer pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView;

/**
 *  设置网络图片轮播图
 *
 *  @param view           当前控制器View
 *  @param sizeY          轮播视图Y值
 *  @param height         轮播图高度
 *  @param pageY          pageController高度
 *  @param imageLinkArray 轮播图数组
 *  @param timeInterval   轮播图轮播时间
 *  @param animateTimer   轮播图完成一次轮播的时间
 */
- (void)dw_SetNetworkingShufflingFigureView:(UIView *)view sizeY:(CGFloat)sizeY  height:(CGFloat)height pageY:(CGFloat)pageY imageLinkArray:(NSArray *)imageLinkArray timeInterval:(NSTimeInterval)timeInterval animateTimer:(NSTimeInterval)animateTimer pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView;

/** 删除PageController */
- (void)dw_removePageControl;

/** 暂时停止自动轮播 */
- (void)dw_stopShuffling;

/** 开启自动轮播 */
- (void)dw_startShuffling;

/** 关闭自动轮播 */
- (void)dw_dismissShuffling;

@end
