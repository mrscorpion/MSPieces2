//
//  UserPageInfoModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface UserPageInfoModel : BSModel
/**
 *  背景图片
 */
@property (copy, nonatomic) NSString *coverimg;
/**
 *  个性签名
 */
@property (copy, nonatomic) NSString *desc;
/**
 *  头像
 */
@property (copy, nonatomic) NSString *icon;
/**
 *  用户ID
 */
@property (copy, nonatomic) NSString *uid;

/**
 *  用户名字
 */
@property (copy, nonatomic) NSString *uname;

@end
