//
//  UserHeaderView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserHeaderView.h"
#import "UserPageInfoModel.h"

@implementation UserHeaderView

- (void)dealloc {
//    [_backImageView release];
//    [_userIcon release];
//    [_followButton release];
//    [_userName release];
//    [_descLabel release];
//    [super dealloc];
}

- (void)setHeaderViewInfo:(UserPageInfoModel *)headerViewInfo{
    if (_headerViewInfo != headerViewInfo) {
//        [_headerViewInfo release];
//        _headerViewInfo = [headerViewInfo retain];
    }
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:_headerViewInfo.coverimg] placeholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:_headerViewInfo.icon] placeholderImage:[UIImage imageNamed:@"userPlaceHolder"]];
    [self.userName setText:_headerViewInfo.uname];
    [self.descLabel setText:_headerViewInfo.desc];
}

- (IBAction)followAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"＋关注"]) {
        [button setTitle:@"已关注" forState:UIControlStateNormal];
    } else{
        [button setTitle:@"＋关注" forState:UIControlStateNormal];
    }
    [_delegate selectedButton:button];
}
@end
