# DWSwipeGestures
#如果喜欢，请Star
---
###简化手势使用,支持CocoaPods导入📦
 ---
# CocoaPods
     platform :ios, '8.0'
     pod 'DWSwipeGestures'#简化手势使用
   
 ---  
#Clone
	cd 本地路径
	---
	git clone https://github.com/dwanghello/DWSwipeGesture.git
---
---
####导入封装完成文件
     DWSwipeGestures.h & DWSwipeGestures.m 或者直接将文件夹导入(DWSwipeGestures)
---
---
#使用
####1、导入头文件/创建对象
	#import "DWSwipeGestures.h"
 ---
	@property (strong, nonatomic) DWSwipeGestures *swip;
 ---
 	//懒加载
	- (DWSwipeGestures *)swip {
    
		 if (!_swip) {
        
		 _swip = [[DWSwipeGestures alloc] init];
        
		 }
    
    	return _swip;
    
	}

 ---
 ---
####2、创建手势/添加手势方法

    //需要进行几次点击/只有敲击手势时才使用此属性/默认为1
      self.swip.numberOfTapsRequired = 2;
    
    //需要进行操作的手指数量/默认为1
    self.swip.numberOfTouchesRequired = 2;

	   /*!
 	    *  @author dwang_sui, 16-07-14 22:07:59
	    *
 	    *  @brief 添加手势
        *  @param swipeGesture                手势类型
	    *  @param target                      方法执行者
	    *  @param action                      方法名
	    *  @param view                        手势添加视图
	    *  @param backSwipeGestureTypeString  返回出设置的手势类型
	    *
	    */
	[self.swip dw_SwipeGestureType:DWUpSwipeGestures Target:self Action:@selector(click) AddView:self.view BackSwipeGestureTypeString:^(NSString * _Nonnull backSwipeGestureTypeString) {
        
        NSLog(@"%@",backSwipeGestureTypeString);
        
    }];
    
 ---
 ---
 
      - (void)click {

        NSLog(@"选择类型为第%lu个枚举值",(unsigned long)self.swip.swipeGestureType);    

	      /**
 	      *  删除手势
	      *
 	      *  @param swipeGestureType 需要删除的手势类型
      	*/
      	 [self.swip dw_RemoveSwipeGesture:DWUpSwipeGestures];
    
	}
#欢迎各位使用，如果有什么更好的使用想法，可以私密我。
