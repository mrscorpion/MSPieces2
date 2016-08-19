//
//  UserPageRadioCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class UserPageDetailModel;


@interface UserPageRadioCell : BSTableViewCell

@property (retain, nonatomic) UserPageDetailModel *detailModel;

@property (retain, nonatomic) IBOutlet UILabel *addTime;
@property (retain, nonatomic) IBOutlet UIImageView *radioImageView;
@property (retain, nonatomic) IBOutlet UILabel *radioLabel;
@property (retain, nonatomic) IBOutlet UILabel *listenNumber;




@end
