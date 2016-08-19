//
//  UserPageTopicCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserPageTopicCell.h"
#import "UserPageDetailModel.h"


@implementation UserPageTopicCell

- (void)setDetailModel:(UserPageDetailModel *)detailModel{
    if (_detailModel != detailModel) {
//        [_detailModel release];
//        _detailModel = [detailModel retain];
    }
    [self.addTime setText:_detailModel.addtime_f];
    [self.topicImage sd_setImageWithURL:[NSURL URLWithString:_detailModel.coverimg ] placeholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];
    [self.title setText:_detailModel.title];
    [self.descLabel setText:_detailModel.content];
}


- (void)dealloc {
//    [_detailModel release];
//    [_addTime release];
//    [_title release];
//    [_topicImage release];
//    [_descLabel release];
//    [super dealloc];
}
@end
