//
//  SearchUserCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"

@class UserInfo;

@interface SearchUserCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) IBOutlet UIImageView *userIcon;
@property (retain, nonatomic) UserInfo *cellContent;
@end
