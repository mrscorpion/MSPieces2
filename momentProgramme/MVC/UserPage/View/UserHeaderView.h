//
//  UserHeaderView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"
@class UserPageInfoModel;

@protocol UserHeaderViewDelegate <NSObject>

- (void)selectedButton:(UIButton *)button;

@end

@interface UserHeaderView : BSView
@property (retain, nonatomic) UserPageInfoModel *headerViewInfo;
@property (retain, nonatomic) IBOutlet UIImageView *backImageView;
@property (retain, nonatomic) IBOutlet UIImageView *userIcon;
@property (retain, nonatomic) IBOutlet UIButton *followButton;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *descLabel;
@property (assign, nonatomic) id<UserHeaderViewDelegate> delegate;

@end
