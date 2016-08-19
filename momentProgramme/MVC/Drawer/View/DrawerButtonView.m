//
//  DrawerButtonView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "DrawerButtonView.h"
@implementation DrawerButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat btnWidth = 220 / 12;
        for (int i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTag:10000 + i];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"DrawerIcon_four_%d",i + 1] ] forState:UIControlStateNormal];
            [button setFrame:CGRectMake(btnWidth  + i * 3 * btnWidth, frame.size.height / 2 - btnWidth / 2, btnWidth, btnWidth)];
            [button addTarget:self action:@selector(fourButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }

    }
    return self;
}

- (void)fourButtonAction:(UIButton *)button{
    [_delegate selectedButton:button];
}

@end
