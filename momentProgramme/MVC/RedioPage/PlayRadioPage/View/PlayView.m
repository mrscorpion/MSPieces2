//
//  PlayView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PlayView.h"


#import "PlayInfo.h"
#import "ASValueTrackingSlider.h"
#import "AutoSize.h"

@interface PlayView ()

@property (retain, nonatomic) UIImageView *radioImageView;
@property (retain, nonatomic) UILabel *titleLable;
@property (retain, nonatomic) UILabel *currentTime;
@property (retain, nonatomic) UILabel *allTime;
@property (assign, nonatomic) BOOL sliderIsDraging;



@end


@implementation PlayView
- (void)dealloc
{
//    [_slider release];
//    [_currentTime release];
//    [_allTime release];
//    [_titleLable release];
//    [_playInfo release];
//    [_radioImageView release];
//    [super dealloc];
}

- (void)setPlayInfo:(PlayInfo *)playInfo{
    if (_playInfo != playInfo) {
//        [_playInfo release];
//        _playInfo = [playInfo retain];
    }
    [self.radioImageView sd_setImageWithURL:[NSURL URLWithString:_playInfo.imgUrl] placeholderImage:[UIImage imageNamed:@"squarePlaceHolder"]];
    [self.titleLable setText:_playInfo.title];
}

- (void)setCurrentTime:(NSString *)currentTime andAllTime:(NSString *)allTime andProgress:(CGFloat)progress{
    [self.currentTime setText:currentTime];
    [self.allTime setText:allTime];
    if (self.sliderIsDraging == NO) {
        [self.slider setValue:progress animated:YES];
    }
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.sliderIsDraging = NO;
        self.radioImageView = [[UIImageView alloc] init];
        [self addSubview:_radioImageView];
//        [_radioImageView release];
        
        self.titleLable = [[UILabel alloc] init];
        [_titleLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
        [_titleLable setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_titleLable];
//        [_titleLable release];
        
        
        self.slider = [[ASValueTrackingSlider alloc]init];
        [self.slider setContinuous:NO];
        [self.slider addTarget:self action:@selector(overTouch) forControlEvents:UIControlEventValueChanged];
        [self.slider addTarget:self action:@selector(beginTouch) forControlEvents:UIControlEventTouchDown];
        [self.slider setThumbImage:[UIImage imageNamed:@"Play_Slider"] forState:UIControlStateNormal];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setNumberStyle:NSNumberFormatterPercentStyle];
        [self.slider setNumberFormatter:formatter];
        self.slider.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
        self.slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:13];
        [self addSubview:_slider];
//        [_slider release];
        
        
        self.currentTime = [[UILabel alloc] init];
        [_currentTime setFont:[UIFont systemFontOfSize:13]];
        [_currentTime setTextAlignment:NSTextAlignmentRight];
        [_currentTime setText:@"00:00"];
        [_currentTime setTextColor:[UIColor colorWithWhite:0.569 alpha:1.000]];
        [self addSubview:_currentTime];
//        [_currentTime release];
        
        self.allTime = [[UILabel alloc] init];
        [_allTime setFont:[UIFont systemFontOfSize:13]];
        [_allTime setText:@"00:00"];
        [_allTime setTextColor:[UIColor colorWithWhite:0.569 alpha:1.000]];
        [self addSubview:_allTime];
//        [_allTime release];
    }
    return self;
}

- (void)beginTouch{
    self.sliderIsDraging = YES;
    NSLog(@"点了啊!");
}
- (void)overTouch{
    self.sliderIsDraging = NO;
    [_delegate sliderChangeTheValue:_slider.value];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageViewWidth = kViewHeight / 1.5;
    CGFloat sliderWidth = kViewWidth - 150;
    [_radioImageView setFrame:CGRectMake((kViewWidth - imageViewWidth) / 2, 20, imageViewWidth, imageViewWidth)];

    [_titleLable setFrame:CGRectMake(_radioImageView.left, _radioImageView.bottom + 30, imageViewWidth, 20)];
    [_slider setFrame:CGRectMake(75, _titleLable.bottom + 20, sliderWidth, 10)];
    [_currentTime setFrame:CGRectMake(_slider.left - 50, _slider.center.y - 10, 45, 20)];
    [_allTime setFrame:CGRectMake(_slider.right + 5, _slider.center.y - 10, 45, 20)];
}

@end
