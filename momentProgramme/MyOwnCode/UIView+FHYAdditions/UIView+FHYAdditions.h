//
//  UIView+FHYAdditions.h
//  UIView+ Additions
//
//  Created by mr.scorpion on 15/10/29.
//  Copyright (c) 2015年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FHYAdditions)
/**
 *  移除所有子视图
 */
-(void)removeAllSubViews;



// Position of the top-left corner in superview's coordinates
/**
 *  view的坐标(x,y)
 */
@property CGPoint position;
/**
 *  view的x
 */
@property CGFloat x;
/**
 *  view的y
 */
@property CGFloat y;
/**
 *  view的x
 */
@property CGFloat top;
/**
 *  view的底部y值
 */
@property CGFloat bottom;
/**
 *  view的靠左x值
 */
@property CGFloat left;
/**
 *  view的靠右x值
 */
@property CGFloat right;


// makes hiding more logical
@property BOOL	visible;


// Setting size keeps the position (top-left corner) constant
/**
 *  view的尺寸
 */
@property CGSize size;
/**
 *  view的宽度
 */
@property CGFloat width;
/**
 *  view的高度
 */
@property CGFloat height;

@end
