//
//  DrawerRadioView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "DrawerRadioView.h"
#import "PlayInfo.h"
#import "UserInfo.h"
#import "StreamKitHandle.h"


@interface DrawerRadioView ()
@property (retain, nonatomic) IBOutlet UIImageView *radioImageView;
@property (retain, nonatomic) IBOutlet UILabel *radioTitle;
@property (retain, nonatomic) IBOutlet UILabel *radioAuthor;
@property (retain, nonatomic) IBOutlet UIButton *playOrPause;



@end

@implementation DrawerRadioView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRadioInfo:) name:@"DrawerRadioChange" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeRadioPlayState:) name:@"PlayOrPause" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanInfo:) name:@"JingJingClean" object:nil];
    }
    return self;
}

- (void)cleanInfo:(NSNotification *)notification{
    [self.radioImageView setImage:[UIImage imageNamed:@"RadioPlaceHolder"]];
    [self.radioTitle setText:@""];
    [self.radioAuthor setText:@""];
}
- (void)changeRadioInfo:(NSNotification *)notification{
    PlayInfo *playInfo = [notification.userInfo objectForKey:@"radioInfo"];
    [self.radioImageView sd_setImageWithURL:[NSURL URLWithString:playInfo.imgUrl]];
    [self.radioTitle setText:playInfo.title];
    [self.radioAuthor setText:playInfo.authorInfo.uname];
    [self.playOrPause setBackgroundImage:[UIImage imageNamed:@"Drawer_Play"] forState:UIControlStateNormal];
}


- (void)changeRadioPlayState:(NSNotification *)notification{
    NSString *getState = [notification.userInfo objectForKey:@"PlayOrPause"];
    if ([getState isEqualToString:@"按钮变暂停"]) {
        [self.playOrPause setBackgroundImage:[UIImage imageNamed:@"Drawer_Pause"] forState:UIControlStateNormal];
    } else{
        [self.playOrPause setBackgroundImage:[UIImage imageNamed:@"Drawer_Play"] forState:UIControlStateNormal];
    }
}


- (IBAction)playOrPause:(id)sender {
    if ([[StreamKitHandle shareStreamKitHandle] currentPlayInfo]) {
        if ([[self.playOrPause backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Drawer_Play"]]) {
            [[StreamKitHandle shareStreamKitHandle] resume];
        } else{
            [[StreamKitHandle shareStreamKitHandle] pause];
        }
    }
}




- (void)dealloc {
//    [_radioImageView release];
//    [_radioTitle release];
//    [_radioAuthor release];
//    [_playOrPause release];
//    [super dealloc];
}
@end
