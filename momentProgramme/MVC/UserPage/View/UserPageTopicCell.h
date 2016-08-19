//
//  UserPageTopicCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class UserPageDetailModel;

@interface UserPageTopicCell : BSTableViewCell
@property (retain, nonatomic) UserPageDetailModel *detailModel;

@property (retain, nonatomic) IBOutlet UILabel *addTime;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UIImageView *topicImage;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;

@end
