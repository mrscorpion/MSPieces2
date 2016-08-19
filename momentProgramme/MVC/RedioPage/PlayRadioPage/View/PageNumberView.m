//
//  PageNumberView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PageNumberView.h"
//TAG 15000 + 3
@implementation PageNumberView


- (instancetype)init{
    self = [super init];
    if (self) {
        for (NSInteger i = 0; i < 3; i++) {
            UIView *fourHappyView = [[UIView alloc]init];
            [fourHappyView setTag:15000 + i];
            if (i == 1) {
               [fourHappyView setBackgroundColor:[UIColor colorWithRed:0.467 green:0.718 blue:0.275 alpha:1.000]];
            } else{
                [fourHappyView setBackgroundColor:[UIColor colorWithWhite:0.757 alpha:1.000]];
            }
            [self addSubview:fourHappyView];
//            [fourHappyView release];
        }
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewWidth = (kViewWidth - 2 * 10) / 3;
    for (NSInteger i = 0; i < 3; i++) {
        [[self viewWithTag:15000 + i] setFrame:CGRectMake(0 + i * (10 + viewWidth), kViewHeight / 2 - 1, viewWidth, 2)];
    }
}

- (void)setHighLightNumber:(NSInteger)highLightNumber{
    for (NSInteger i = 0; i < 3; i++) {
        if (i == highLightNumber) {
            [[self viewWithTag:15000 + i] setBackgroundColor:[UIColor colorWithRed:0.467 green:0.718 blue:0.275 alpha:1.000]];
        } else{
            [[self viewWithTag:15000 + i] setBackgroundColor:[UIColor colorWithWhite:0.757 alpha:1.000]];
        }
    }
}

@end
