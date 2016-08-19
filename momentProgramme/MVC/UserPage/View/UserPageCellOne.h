//
//  UserPageCellOne.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class UserPageDetailModel;

@interface UserPageCellOne : BSTableViewCell

@property (retain, nonatomic) UserPageDetailModel *detailModel;
@property (retain, nonatomic) UIImageView *pic;

@end
