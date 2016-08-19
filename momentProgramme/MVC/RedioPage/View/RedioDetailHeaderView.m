//
//  RedioDetailHeaderView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioDetailHeaderView.h"
#import "RadioListInfoModel.h"
#import "UserInfo.h"
#import <UIButton+WebCache.h>
@interface RedioDetailHeaderView ()
@property (retain, nonatomic) IBOutlet UILabel *listenNumber;
@property (retain, nonatomic) IBOutlet UILabel *subTitle;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UIImageView *headImage;

@end

@implementation RedioDetailHeaderView
- (void)dealloc
{
//    [_radioListInfo release];
//    [_listenNumber release];
//    [_subTitle release];
//    [_userName release];
//    [_userIcon release];
//    [_headImage release];
//    [super dealloc];
}



- (void)setRadioListInfo:(RadioListInfoModel *)radioListInfo{
    if (_radioListInfo != radioListInfo) {
//        [_radioListInfo release];
//        _radioListInfo = [radioListInfo retain];
    }
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:_radioListInfo.coverimg] placeholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];

    dispatch_queue_t queue = dispatch_get_global_queue(0 , 0);
    dispatch_async(queue, ^{
        NSData *temp= [NSData dataWithContentsOfURL:[NSURL URLWithString:_radioListInfo.userInfo.icon]];
    dispatch_async(dispatch_get_main_queue(), ^{
      [self.userIcon setBackgroundImage:[UIImage imageWithData:temp] forState:UIControlStateNormal];
        });
    });
    
    [self.listenNumber setText:[NSString stringWithFormat:@"♪ %@",_radioListInfo.musicvisitnum]];
    [self.userName setText:_radioListInfo.userInfo.uname];
    [self.subTitle setText:_radioListInfo.desc];
}

@end
