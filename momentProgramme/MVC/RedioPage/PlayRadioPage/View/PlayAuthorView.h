//
//  PlayAuthorView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"
@class UserInfo;
@interface PlayAuthorView : BSView
@property (retain, nonatomic)UserInfo *authorInfo;
@property (retain, nonatomic)UserInfo *radioAuthorInfo;
@property (retain, nonatomic) IBOutlet UIButton *authorButton;
@property (retain, nonatomic) IBOutlet UIButton *radioAuthorButton;


@end
