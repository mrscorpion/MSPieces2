//
//  UIView+FHYAdditions.m
//  UIView+ Additions
//
//  Created by mr.scorpion on 15/10/29.
//  Copyright (c) 2015年 mr.scorpion. All rights reserved.
//

#import "UIView+FHYAdditions.h"

@implementation UIView (FHYAdditions)
- (CGPoint)position {
    return self.frame.origin;
}

- (void)setPosition:(CGPoint)position {
    CGRect rect = self.frame;
    rect.origin = position;
    [self setFrame:rect];
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    [self setFrame:rect];
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    [self setFrame:rect];
}


- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}





- (BOOL)visible {
    return !self.hidden;
}

- (void)setVisible:(BOOL)visible {
    self.hidden=!visible;
}


-(void)removeAllSubViews{
    
    for (UIView *subview in self.subviews){
        [subview removeFromSuperview];
    }
    
}


- (CGSize)size {
    return [self frame].size;
}

- (void)setSize:(CGSize)size {
    CGRect rect = self.frame;
    rect.size = size;
    [self setFrame:rect];
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    [self setFrame:rect];
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    [self setFrame:rect];
}

@end
