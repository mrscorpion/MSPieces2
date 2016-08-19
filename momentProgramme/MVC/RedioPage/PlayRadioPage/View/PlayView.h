//
//  PlayView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"
@class PlayInfo;
#import "ASValueTrackingSlider.h"
@protocol PlayViewDelegate <NSObject>

- (void)sliderChangeTheValue:(CGFloat)value;

@end

@interface PlayView : BSView
@property (retain, nonatomic) ASValueTrackingSlider *slider;
@property (assign, nonatomic) id<PlayViewDelegate> delegate;
@property (retain, nonatomic) PlayInfo *playInfo;

- (void)setCurrentTime:(NSString *)currentTime andAllTime:(NSString *)allTime andProgress:(CGFloat)progress;
@end
