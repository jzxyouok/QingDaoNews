
//
//  UIView+Extension.m
//  News
//
//  Created by Dwang on 16/3/20.
//  Copyright © 2016年 冬～. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

//X
- (void) setX:(CGFloat)x {
    
    CGRect rect = self.frame;
    
    x = rect.origin.x;;
    
    self.frame = rect;
}

- (CGFloat) x {
    
    return self.frame.origin.x;
    
}

//Y
- (void) setY:(CGFloat)y {
    
    CGRect rect = self.frame;
    
    y = rect.origin.y;
    
    self.frame = rect;
    
}


- (CGFloat) y {
    
    return self.frame.origin.y;
    
}



//Width
- (void) setWidth:(CGFloat)width {
    
    CGRect rect = self.frame;
    
    width = rect.size.width;
    
}

- (CGFloat) width {
    
    return self.frame.size.width;
    
}


//Height
- (void) setHeight:(CGFloat)height {
    
    CGRect rect = self.frame;
    
    height = rect.size.height;
    
}

- (CGFloat) height {
    
    return self.frame.size.height;
    
}


//Origin
- (void) setOrigin:(CGPoint)origin {
    
    CGRect rect = self.frame;
    
    origin = rect.origin;;
    
    self.frame = rect;;
    
}

- (CGPoint) origin {
    
    return self.frame.origin;
    
}



//Size
- (void) setSize:(CGSize)size {
    
    CGRect rect = self.frame;
    
    size = rect.size;
    
    self.frame = rect;
    
}

- (CGSize) size {
    
    return self.frame.size;
    
}





//CenterX
- (void) setCenterX:(CGFloat)centerX {
    
    CGPoint point = self.center;
    
    centerX = point.x;
    
    self.center = point;
    
}

- (CGFloat) centerX {
    
    return self.centerX;
    
}



//CenterY
- (void) setCenterY:(CGFloat)centerY {
    
    CGPoint point = self.center;
    
    centerY = point.y;
    
    self.center = point;
    
}

- (CGFloat) centerY {
    
    return self.centerY;
    
}


@end
