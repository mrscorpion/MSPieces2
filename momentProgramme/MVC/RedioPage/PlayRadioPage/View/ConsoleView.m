//
//  ConsoleView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ConsoleView.h"

@interface ConsoleView ()
@property (retain, nonatomic) UIView *happyView;
@end

@implementation ConsoleView
- (void)dealloc
{
//    [_happyView release];
//    [_pageNumberView release];
//    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.pageNumberView = [PageNumberView new];
        [self addSubview:_pageNumberView];
//        [_pageNumberView release];
        
        self.happyView = [UIView new];
        [self.happyView setBackgroundColor:[UIColor colorWithWhite:0.718 alpha:1.000]];
        [self addSubview:_happyView];
//        [_happyView release];
        
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [playButton setTag:17000 + i];
            [playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [playButton.layer setMasksToBounds:YES];
            [playButton.layer setBorderWidth:2];
            [playButton.layer setBorderColor:[UIColor colorWithRed:0.910 green:0.914 blue:0.910 alpha:1.000].CGColor];
            if (i == 1) {
                [playButton.layer setCornerRadius:20];
                [playButton setBackgroundImage:[UIImage imageNamed:@"PlayButton_1_Pause"] forState:UIControlStateNormal];
            } else {
                [playButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"PlayButton_%ld",i]] forState:UIControlStateNormal];
                [playButton.layer setCornerRadius:15];
            }
            [self addSubview:playButton];
        }
    }
    return self;
}


- (void)playButtonAction:(UIButton *)playButton{
    switch (playButton.tag) {
        case 17000:
            [_delegate clickedButton:PlayButtonLastType andTouchButton:playButton];
            break;
        case 17001:
            [_delegate clickedButton:PlayButtonPlayType andTouchButton:playButton];

            break;
        case 17002:
            [_delegate clickedButton:PlayButtonNextType andTouchButton:playButton];
            break;
        default:
            break;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat pageNumberViewWidth = kViewWidth / 8;
    [self.pageNumberView setFrame:CGRectMake(kViewWidth / 2 - pageNumberViewWidth / 2 , 10, pageNumberViewWidth, 3)];
    [self.happyView setFrame:CGRectMake(30, _pageNumberView.bottom + 10, kViewWidth - 60, 1)];
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *playButton = [self viewWithTag:17000 + i];
        switch (i) {
            case 0:
            [playButton setFrame:CGRectMake(_happyView.left + 10, _happyView.bottom + 15, 30, 30)];
                break;
            case 1:
                [playButton setFrame:CGRectMake(_happyView.center.x - 20, _happyView.bottom + 10, 40, 40)];
                break;
            case 2:
                [playButton setFrame:CGRectMake(_happyView.right - 40, _happyView.bottom + 15, 30, 30)];
                break;
            default:
                break;
        }
    }
}
@end
