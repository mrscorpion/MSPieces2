//
//  UserInfo.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface UserInfo : BSModel
/**
 *  用户头像
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  用户UID
 */
@property (copy, nonatomic) NSString *uid;
/**
 *  用户名
 */
@property (copy, nonatomic) NSString *uname;


@end
