//
//  DWNewFeatures.m
//  DWNewFeatures
//
//  Created by cdk on 16/8/2.
//  Copyright © 2016年 dwang_sui. All rights reserved.
//----------------------------QQ:739814184-----------------------
//----------------------------e-mail:dwang.hello@outlook.com-------------------

#import "DWScrollPictures.h"
#import "UIView+Extension.h"
#import "DWSwipeGestures.h"

@interface DWScrollPictures ()<UIScrollViewDelegate>

//获取屏幕 宽度、高度
#define DWScreen_Frame [UIScreen mainScreen].bounds
#define DWScreen_Width [UIScreen mainScreen].bounds.size.width
#define DWScreen_Height [UIScreen mainScreen].bounds.size.height

//偏好设置
#define DWUser_Defaults [NSUserDefaults standardUserDefaults]

/** pageController */
@property (weak, nonatomic) UIPageControl       *pageControl;

/** 新特性本地图片数组 */
@property (strong, nonatomic) NSArray           *NewFeaturesImageNameArray;

/** 新特性网络图片数组 */
@property (strong, nonatomic) NSArray           *NewFeaturesImageLinkArray;

/** 轮播图本地图片数组 */
@property (strong, nonatomic) NSMutableArray    *shufflingFigureImageNameArray;

/** 轮播图网络图片数组 */
@property (strong, nonatomic) NSMutableArray    *shufflingFigureImageLinkArray;

/** 轮播图完成一次轮播的时间 */
@property (assign, nonatomic) NSTimeInterval    animateTimer;

/** 是否开启轮播 */
@property (assign, nonatomic) BOOL              isbool;

/** 是否是手动拖动图片 */
@property (assign, nonatomic) BOOL              slide;

/** 轮播图计时器 */
@property (weak, nonatomic) NSTimer             *shufflingTimer;

/** 轮播图计时器时间 */
@property (assign, nonatomic) NSTimeInterval    timeInterval;

/** 点击图片手势 */
@property (strong, nonatomic) DWSwipeGestures   *tapGesture;

/** 本地被点击图片的tag值 */
@property (assign, nonatomic) NSInteger         shufflingFigureImageTag;

/** 网络被点击图片的tag值 */
@property (assign, nonatomic) NSInteger         shufflingFigureImageLinkTag;

/** 本地轮播图数组 */
@property (strong, nonatomic) NSMutableArray    *shufflingFigurepPageViewArray;

/** 网络轮播图数组 */
@property (strong, nonatomic) NSMutableArray    *shufflingFigurepLinkPageViewArray;

@property (strong, nonatomic) CATransition *animation;


@property (weak, nonatomic) UIScrollView        *scrollView;

@end

#define key_ShortVersion @"key_ShortVersion"
@implementation DWScrollPictures

#pragma mark ---Appdelegate设置引导页控制器
+ (void)dw_AppdelegateNewFeaturesWindow:(UIWindow *)window newFeaturesVC:(id)newFeaturesVC mainVC:(id)mainVC {
    
    //本地保存的版本号
    NSString *localShortVersionStr = [[NSUserDefaults standardUserDefaults] objectForKey:key_ShortVersion];
    
    //取出当前app的版本号
    NSString *currentShortVersionStr = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    //判断当前本地保存的版本号为空,或者本地保存的版本号小于当前app的版本号,就直接进入到新特性页面
    if (!localShortVersionStr || [localShortVersionStr compare:currentShortVersionStr] == NSOrderedAscending || ![DWUser_Defaults boolForKey:@"lastPage"]) {
        
        //进入新特性控制器之前,保存一下当前app的版本号,以便下次进入的时候判断
        [[NSUserDefaults standardUserDefaults] setObject:currentShortVersionStr forKey:key_ShortVersion];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //加载新特性页面
        window.rootViewController = newFeaturesVC;
        
    }else{
        
        //加载首页控制器
        window.rootViewController = mainVC;
        
    }
    
    [window makeKeyAndVisible];
}

#pragma mark ---设置新特性页面/本地图片
- (void)dw_SetNewFeaturesView:(UIView *)view delegate:(id)delegate imageName:(NSArray *)imageNameArray pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView {
    
    self.NewFeaturesImageNameArray = imageNameArray;
    
    self.delegate = delegate;
    
    UIScrollView *scrollView = [self dw_loadScrollerViewSizeY:0 Height:0];
    
    scrollView.frame = DWScreen_Frame;
    
    for (int i = 0; i < [imageNameArray count]; i ++) {
        
        //循环添加imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
        imageView.image = [UIImage imageNamed:imageNameArray[i]];
        
        //设置大小与位置
        imageView.size = scrollView.size;
        
        imageView.x = i * scrollView.width;
        
        [scrollView addSubview:imageView];
        
        
        if (pageImageView) {
            
            imageView.userInteractionEnabled = true;
            
            pageImageView(imageView,i, (int)[imageNameArray count] - 1);
            
        }
    }
    
    //设置scrollView的内容大小
    [scrollView setContentSize:CGSizeMake([imageNameArray count] * scrollView.width, 0)];
    
    [view addSubview:scrollView];
    
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    //设置显示几页
    pageControl.numberOfPages = [imageNameArray count];
    
    //选中的颜色
    if (self.pageSelctColor) {
        
        pageControl.currentPageIndicatorTintColor = self.pageSelctColor;
        
    }else {
        
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
    }
    
    //未选中的颜色
    if (self.pageNormalColor) {
        
        pageControl.pageIndicatorTintColor = self.pageNormalColor;
        
    }else {
        
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    
    [view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    //设置位置
    pageControl.centerX = view.centerX;
    pageControl.y = view.height - 100;
    
    
}

#pragma mark ---设置新特性页面/网络图片
- (void)dw_SetNetworkingNewFeaturesView:(UIView *)view delegate:(id)delegate imageLinkArray:(NSArray *)imageLinkArray pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView {
    
    self.NewFeaturesImageLinkArray = imageLinkArray;
    
    self.delegate = delegate;
    
    UIScrollView *scrollView = [self dw_loadScrollerViewSizeY:0 Height:0];
    
    scrollView.frame = DWScreen_Frame;
    
    for (int i = 0; i < [imageLinkArray count]; i ++) {
        
        //循环添加imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
        NSURL *url = [NSURL URLWithString:imageLinkArray[i]];
        
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            
            UIImage *img = [UIImage imageWithData:resultData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                imageView.image = img;
                
            });
            
        });

        //设置大小与位置
        imageView.size = scrollView.size;
        
        imageView.x = i * scrollView.width;
        
        [scrollView addSubview:imageView];
        
        
        if (pageImageView) {
            
            imageView.userInteractionEnabled = true;
            
            pageImageView(imageView,i, (int)[imageLinkArray count] - 1);
            
        }
    }
    
    //设置scrollView的内容大小
    [scrollView setContentSize:CGSizeMake([imageLinkArray count] * scrollView.width, 0)];
    
    [view addSubview:scrollView];
    
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    //设置显示几页
    pageControl.numberOfPages = [imageLinkArray count];
    
    //选中的颜色
    if (self.pageSelctColor) {
        
        pageControl.currentPageIndicatorTintColor = self.pageSelctColor;
        
    }else {
        
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
    }
    
    //未选中的颜色
    if (self.pageNormalColor) {
        
        pageControl.pageIndicatorTintColor = self.pageNormalColor;
        
    }else {
        
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    
    [view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    //设置位置
    pageControl.centerX = view.centerX;
    pageControl.y = view.height - 100;

    
}

#pragma mark ---设置轮播图／本地图片
- (void)dw_SetShufflingFigureView:(UIView *)view sizeY:(CGFloat)sizeY  height:(CGFloat)height pageY:(CGFloat)pageY imageNameArray:(NSArray *)imageNameArray timeInterval:(NSTimeInterval)timeInterval animateTimer:(NSTimeInterval)animateTimer pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView {
    
    [self.shufflingFigureImageNameArray addObject:imageNameArray.lastObject];
    
    [self.shufflingFigureImageNameArray addObjectsFromArray:imageNameArray];
    
    [self.shufflingFigureImageNameArray addObject:imageNameArray.firstObject];
    
    self.animateTimer = animateTimer;
    
    self.timeInterval = timeInterval;
    
    UIScrollView *scrollView = [self dw_loadScrollerViewSizeY:sizeY Height:height];
    
    for (int i = 0; i < [self.shufflingFigureImageNameArray count]; i ++) {
        
        //循环添加imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.shufflingFigurepPageViewArray addObject:imageView];
        
        imageView.image = [UIImage imageNamed:self.shufflingFigureImageNameArray[i]];
        
        //设置大小与位置
        imageView.size = scrollView.size;
        
        imageView.x = i * scrollView.width;
        
        if (pageImageView) {
            
            imageView.userInteractionEnabled = true;
            
             [self.tapGesture dw_SwipeGestureType:DWTapGesture Target:self Action:@selector(dw_tapGesture) AddView:imageView BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {}];
            
            pageImageView(imageView, i, (int)[self.shufflingFigureImageNameArray count]);
            
        }

        
        [scrollView addSubview:imageView];
        
    }
    
    //设置scrollView的内容大小
    [scrollView setContentSize:CGSizeMake([self.shufflingFigureImageNameArray count] * DWScreen_Width, 0)];
    
    scrollView.contentOffset = CGPointMake(DWScreen_Width, 0);
    
    [view addSubview:scrollView];
    
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    //设置显示几页
    pageControl.numberOfPages = [self.shufflingFigureImageNameArray count] - 2;
    
    //选中的颜色
    if (self.pageSelctColor) {
        
        pageControl.currentPageIndicatorTintColor = self.pageSelctColor;
        
    }else {
        
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
    }
    
    //未选中的颜色
    if (self.pageNormalColor) {
        
        pageControl.pageIndicatorTintColor = self.pageNormalColor;
        
    }else {
        
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    
    [view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    //设置位置
    pageControl.centerX = view.centerX;
    pageControl.y = view.height - pageY;
    
    [self dw_loadSlide];
    
    [self dw_stopShuffling];
    
}

#pragma mark ---设置轮播图／网络图片
- (void)dw_SetNetworkingShufflingFigureView:(UIView *)view sizeY:(CGFloat)sizeY  height:(CGFloat)height pageY:(CGFloat)pageY imageLinkArray:(NSArray *)imageLinkArray timeInterval:(NSTimeInterval)timeInterval animateTimer:(NSTimeInterval)animateTimer pageImageView:(void (^)(UIView *PageImageView, int imageCount, int imageAllCount))pageImageView {
    
    [self.shufflingFigureImageLinkArray addObject:imageLinkArray.lastObject];
    
    [self.shufflingFigureImageLinkArray addObjectsFromArray:imageLinkArray];
    
    [self.shufflingFigureImageLinkArray addObject:imageLinkArray.firstObject];
    
    self.animateTimer = animateTimer;
    
    self.timeInterval = timeInterval;
    
   UIScrollView *scrollView = [self dw_loadScrollerViewSizeY:sizeY Height:height];
    
    for (int i = 0; i < [self.shufflingFigureImageLinkArray count]; i ++) {
        
        //循环添加imageView
        UIImageView *imageView = [[UIImageView alloc] init];
        
        [self.shufflingFigurepLinkPageViewArray addObject:imageView];
        
        imageView.backgroundColor = [UIColor blackColor];
        
        NSURL *url = [NSURL URLWithString:self.shufflingFigureImageLinkArray[i]];
        
        dispatch_queue_t queue =dispatch_queue_create("loadImage",NULL);
        
        dispatch_async(queue, ^{
            
            NSData *resultData = [NSData dataWithContentsOfURL:url];
            
            UIImage *img = [UIImage imageWithData:resultData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                if (img) {
                    
                    imageView.image = img;
                    
                }else {
                    
                    imageView.image = self.defaultImage;
                    
                }
                
            });
            
        });

        //设置大小与位置
        imageView.size = scrollView.size;
        
        imageView.x = i * scrollView.width;
        
        if (pageImageView) {
            
            imageView.tag = i + 1;
            
            imageView.userInteractionEnabled = true;
            
            [self.tapGesture dw_SwipeGestureType:DWTapGesture Target:self Action:@selector(dw_tapGesture) AddView:imageView BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {}];
            
            pageImageView(imageView,i , (int)[self.shufflingFigureImageLinkArray count]);
            
        }

        scrollView.contentOffset = CGPointMake(DWScreen_Width, 0);
        
        [scrollView addSubview:imageView];
        
    }
    
    //设置scrollView的内容大小
    [scrollView setContentSize:CGSizeMake([self.shufflingFigureImageLinkArray count] * scrollView.width, 0)];
    
    [view addSubview:scrollView];
    
    
    //添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    
    //设置显示几页
    pageControl.numberOfPages = [self.shufflingFigureImageLinkArray count] - 2;
    
    //选中的颜色
    if (self.pageSelctColor) {
        
        pageControl.currentPageIndicatorTintColor = self.pageSelctColor;
        
    }else {
        
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
    }
    
    //未选中的颜色
    if (self.pageNormalColor) {
        
        pageControl.pageIndicatorTintColor = self.pageNormalColor;
        
    }else {
        
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        
    }
    
    [view addSubview:pageControl];
    
    self.pageControl = pageControl;
    
    //设置位置
    pageControl.centerX = view.centerX;
    pageControl.y = view.height - pageY;
    
    [self dw_loadSlide];
    
    [self dw_stopShuffling];

}

#pragma mark ---获取点击轮播图索引delegate
- (void) dw_tapGesture{
    
    if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
        
        if ([self.delegate respondsToSelector:@selector(dw_ShufflingFigureSelectImageCount:)]) {
            
            [self.delegate dw_ShufflingFigureSelectImageCount:self.shufflingFigureImageLinkTag];
            
        }
        
    }else if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
        
        if ([self.delegate respondsToSelector:@selector(dw_ShufflingFigureSelectImageCount:)]) {
            
            [self.delegate dw_ShufflingFigureSelectImageCount:self.shufflingFigureImageTag];
            
        }
        
    }
}

#pragma mark ---scrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //计算滑动到第几页
    double page = scrollView.contentOffset.x / scrollView.width;
    
    scrollView.tag = page;
    
    if (self.NewFeaturesImageNameArray) {
        
        self.pageControl.currentPage = (int)(page + 0.5);
        
    }else {
    
    self.pageControl.currentPage = (int)(page + 0.5) - 1;
        
        if (self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 1) || self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 1)) {
            
            self.pageControl.currentPage = 0;
            
        }else if (self.scrollView.contentOffset.x == 0) {
            
            if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
                
                self.pageControl.currentPage = [self.shufflingFigureImageNameArray count] - 2;
                
            }
            
            if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
                
                self.pageControl.currentPage = [self.shufflingFigureImageLinkArray count] - 2;
                
                }
        }
        

        
       if ((int)(page + 0.5) == 0) {
        
        if (self.shufflingFigureImageNameArray) {
            
               self.shufflingFigureImageTag = self.shufflingFigureImageNameArray.count - 3;
        
        }
        
        if (self.shufflingFigureImageLinkArray) {
            
            self.shufflingFigureImageLinkTag = self.shufflingFigureImageLinkArray.count - 3;
            
        }
        
             
    }else if ((int)(page + 0.5) == self.shufflingFigureImageNameArray.count || (int)(page + 0.5) == self.shufflingFigureImageLinkArray.count) {
        
        if (self.shufflingFigureImageNameArray) {
            
            self.shufflingFigureImageTag = 0;
            
        }
        
        if (self.shufflingFigureImageLinkArray) {
            
            self.shufflingFigureImageLinkTag = 0;
            
        }
        
    }else {
        
        if (self.shufflingFigureImageNameArray) {
            
            self.shufflingFigureImageTag = (int)(page + 0.5) - 1;
            
        }
        
        if (self.shufflingFigureImageLinkArray) {
            
            self.shufflingFigureImageLinkTag = (int)(page + 0.5) - 1;
            
        }
        
    }
    }
    
    if (page >= self.NewFeaturesImageNameArray.count - 1 || page >= self.NewFeaturesImageLinkArray.count - 1 || self.lastNews) {
        
        [DWUser_Defaults setBool:YES forKey:@"lastPage"];
        
    }
    
    if (self.NewFeaturesImageNameArray) {
        
        //代理方法
        if ([self.delegate respondsToSelector:@selector(dw_nowPageCount:imageAllCount:)]) {
            
            [self.delegate dw_nowPageCount:page imageAllCount:self.NewFeaturesImageNameArray.count - 1];
            
        }

    }else if (self.NewFeaturesImageLinkArray) {
        
        //代理方法
        if ([self.delegate respondsToSelector:@selector(dw_nowPageCount:imageAllCount:)]) {
            
            [self.delegate dw_nowPageCount:page imageAllCount:self.NewFeaturesImageLinkArray.count - 1];
            
        }

    }
    
    if (self.shufflingFigureImageNameArray && self.shufflingFigureImageLinkArray.count == 0) {
        
        if ([self.delegate respondsToSelector:@selector(dw_ShufflingFigureNowPageCount:pageViewArray:pageView:)]) {
            
            [self.delegate dw_ShufflingFigureNowPageCount:page pageViewArray:self.shufflingFigurepPageViewArray pageView:scrollView];
            
        }
        
    }else if (self.shufflingFigureImageLinkArray) {
        
            if ([self.delegate respondsToSelector:@selector(dw_ShufflingFigureNowPageCount:pageViewArray:pageView:)]) {
                
                [self.delegate dw_ShufflingFigureNowPageCount:page pageViewArray:self.shufflingFigureImageLinkArray pageView:scrollView];
                
            }
    }
    
    if ((self.animationType && self.subtype) ||
        (self.animationType == fade && self.subtype == fromLeft) ||
        (self.animationType == fade && self.subtype != fromLeft) ||
        (self.animationType != fade && self.subtype == fromLeft)) {
        
        static NSString *animationType;
        
        static NSString *subtype;
        
        switch (self.animationType) {
            case 0:
                animationType = @"fade";
                break;
            case 1:
                animationType = @"push";
                break;
            case 2:
                animationType = @"reveal";
                break;
            case 3:
                animationType = @"moveIn";
                break;
            case 4:
                animationType = @"cube";
                break;
            case 5:
                animationType = @"suckEffect";
                break;
            case 6:
                animationType = @"oglFlip";
                break;
            case 7:
                animationType = @"rippleEffect";
                break;
            case 8:
                animationType = @"pageCurl";
                break;
            case 9:
                animationType = @"pageUnCurl";
                break;
            case 10:
                animationType = @"cameraIrisHollowOpen";
                break;
            case 11:
                animationType = @"cameraIrisHollowClose";
                break;
            case 12:
                animationType = @"curlDown";
                break;
            case 13:
                animationType = @"curlUp";
                break;
            case 14:
                animationType = @"flipFromLeft";
                break;
            case 15:
                animationType = @"flipFromRight";
                break;
                
            default:
                break;
        }
        
        switch (self.subtype) {
            case 0:
                subtype = @"fromLeft";
                break;
            case 1:
                subtype = @"fromRight";
                break;
            case 2:
                subtype = @"fromTop";
                break;
            case 3:
                subtype = @"fromBottom";
                break;
            default:
                break;
        }
        
        CATransition *animation = [CATransition animation];
        
        self.animation = animation;
        
        animation.type = animationType;
        
        animation.subtype = subtype;
        
        if (self.duration) {
            
            animation.duration = self.duration;
            
        }else {
            
            animation.duration = self.animateTimer;
            
        }
        
        [scrollView.layer addAnimation:animation forKey:nil];
        
    }
    
}

#pragma mark ---开始移动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.shufflingTimer setFireDate:[NSDate distantFuture]];
    
    self.slide = YES;
    
    
}

#pragma mark ---移动完成
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    if (self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 1) || self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 1)) {
        
        self.pageControl.currentPage = 0;
        
        self.scrollView.contentOffset = CGPointMake(DWScreen_Width, 0);
        
    }else if (self.scrollView.contentOffset.x == 0) {
        
        if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 2), 0);
         
        }
        
        if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 2), 0);
            
        }
    }

    if (self.isbool && self.slide) {

        [self.shufflingTimer setFireDate:[NSDate distantPast]];
    
        self.slide = NO;
    }
    
}

#pragma mark ---开启正向轮播
- (void)startFollowShuffling {
    
    self.isbool = YES;
    
        [UIView animateWithDuration:self.animateTimer animations:^{
    
            self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x + DWScreen_Width, 0);
            
        }];
    
    if (self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 1) || self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 1)) {
        
        self.scrollView.contentOffset = CGPointMake(DWScreen_Width, 0);
        
    }else if (self.scrollView.contentOffset.x == 0) {
        
        if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 2), 0);
            
        }
        
        if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 2), 0);
            
        }
        
    }

}

#pragma mark ---开启反向轮播
- (void)startGoAgainstShuffling {
    
    self.isbool = YES;
    
    [UIView animateWithDuration:self.animateTimer animations:^{
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x - DWScreen_Width, 0);
        
    }];
    
    if (self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 1) || self.scrollView.contentOffset.x == DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 1)) {
        
        self.pageControl.currentPage = 0;
        
        self.scrollView.contentOffset = CGPointMake(DWScreen_Width, 0);
        
    }else if (self.scrollView.contentOffset.x == 0) {
        
        if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
            
            self.pageControl.currentPage = [self.shufflingFigureImageNameArray count] - 2;
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 2), 0);
            
        }
        
        if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
            
            self.pageControl.currentPage = [self.shufflingFigureImageLinkArray count] - 2;
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 2), 0);
            
        }
        
    }
}

#pragma mark ---关闭定时器
- (void)dw_stopShuffling {
    
    self.isbool = NO;
    
    [self.shufflingTimer setFireDate:[NSDate distantFuture]];
}

#pragma mark ---开启定时器
- (void)dw_startShuffling {
    
    [self.shufflingTimer setFireDate:[NSDate distantPast]];
    
}

#pragma mark ---取消定时器
- (void)dw_dismissShuffling {
    
    [self.shufflingTimer invalidate];
    
    self.shufflingTimer = nil;
    
}

#pragma mark ---删除pageController
- (void)dw_removePageControl {
    
    [self.pageControl removeFromSuperview];
    
}

#pragma mark ---加载ScrollerView
- (UIScrollView *)dw_loadScrollerViewSizeY:(CGFloat)sizeY Height:(CGFloat)height {
    
    //初始化一个ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, sizeY, DWScreen_Width, height)];
    
    self.scrollView = scrollView;
    
    //隐藏水平方向的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //开启分页
    scrollView.pagingEnabled = YES;
    
    //监听滑动-->成为代理
    scrollView.delegate = self;
    
    return scrollView;
    
}

#pragma mark ---设置scrollerView滑动方向
- (void)dw_loadSlide {
    
    if (self.direction == DWFollowShuffling) {
        
        self.shufflingTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(startFollowShuffling) userInfo:nil repeats:YES];
        
    }else if (self.direction == DWGoAgainstShuffling) {
        
        self.shufflingTimer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(startGoAgainstShuffling) userInfo:nil repeats:YES];
        
        if (self.shufflingFigureImageNameArray && self.shufflingFigureImageNameArray.count > 0) {
            
            
            self.pageControl.currentPage = self.shufflingFigureImageNameArray.count - 2;
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageNameArray count] - 2), 0);
            
        }
        
        if (self.shufflingFigureImageLinkArray && self.shufflingFigureImageLinkArray.count > 0) {
            
            self.pageControl.currentPage = self.shufflingFigureImageNameArray.count - 2;
            
            self.scrollView.contentOffset = CGPointMake(DWScreen_Width * ([self.shufflingFigureImageLinkArray count] - 2), 0);
            
        }
        
    }

    
}

#pragma mark ---懒加载手势
- (DWSwipeGestures *)tapGesture {
    
    if (!_tapGesture) {
        
        _tapGesture = [[DWSwipeGestures alloc] init];
        
    }
    
    return _tapGesture;
    
}

#pragma mark ---懒加载本地图片数组
- (NSMutableArray *)shufflingFigureImageNameArray {
    
    if (!_shufflingFigureImageNameArray) {
        
        _shufflingFigureImageNameArray = [NSMutableArray array];
        
    }
    
    return _shufflingFigureImageNameArray;
    
}

#pragma mark ---懒加载网络图片数组
- (NSMutableArray *)shufflingFigureImageLinkArray {
    
    if (!_shufflingFigureImageLinkArray) {
        
        _shufflingFigureImageLinkArray = [NSMutableArray array];
        
    }
    
    return _shufflingFigureImageLinkArray;
}

#pragma mark ---懒加载本地轮播图视图数组
- (NSMutableArray *)shufflingFigurepPageViewArray {
    
    if (!_shufflingFigurepPageViewArray) {
        
        _shufflingFigurepPageViewArray = [NSMutableArray array];
        
    }
    
    return _shufflingFigurepPageViewArray;
    
}

#pragma mark ---懒加载本地轮播图视图数组
- (NSMutableArray *)shufflingFigurepLinkPageViewArray {
    
    if (!_shufflingFigurepLinkPageViewArray) {
        
        _shufflingFigurepLinkPageViewArray = [NSMutableArray array];
        
    }
    
    return _shufflingFigurepLinkPageViewArray;
    
}


@end
