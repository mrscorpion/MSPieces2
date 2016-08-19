//
//  AutoSize.h
//  AutoSizeHeightOrWidth
//
//  Created by mr.scorpion on 15/10/7.
//  Copyright (c) 2015年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface AutoSize : NSObject
+ (CGFloat)AutoSizeOfHeightWithText:(NSString *)text andFont:(UIFont *)font andLabelWidth:(CGFloat)width;
+ (CGFloat)AutoSizeOfWidthWithText:(NSString *)text andFont:(UIFont *)font andLabelHeight:(CGFloat)height;
@end
