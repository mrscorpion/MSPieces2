//
//  UserPageRadioCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserPageRadioCell.h"
#import "UserPageDetailModel.h"
#import "PlayInfo.h"

@implementation UserPageRadioCell

- (void)dealloc {
//    [_detailModel release];
//    [_addTime release];
//    [_radioImageView release];
//    [_radioLabel release];
//    [_listenNumber release];
//    [super dealloc];
}

- (void)setDetailModel:(UserPageDetailModel *)detailModel{
    if (_detailModel != detailModel) {
//        [_detailModel release];
//        _detailModel = [detailModel retain];
    }
    [self.addTime setText:_detailModel.addtime_f];
    [self.radioImageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.playinfo.imgUrl] placeholderImage:[UIImage imageNamed:@"RadioPlaceHolder"]];
    [self.radioLabel setText:_detailModel.playinfo.title];
    NSInteger temp = arc4random() % 10000 + 2000;
    [self.listenNumber setText:[NSString stringWithFormat:@"♪ %ld",temp]];
}


@end
