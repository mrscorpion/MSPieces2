//
//  RadioListInfoModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class UserInfo;
@interface RadioListInfoModel : BSModel
/**
 *  头视图照片
 */
@property (copy, nonatomic) NSString *coverimg;
/**
 *  副标题
 */
@property (copy, nonatomic) NSString *desc;
/**
 *  听众数量
 */
@property (copy, nonatomic) NSString *musicvisitnum;
/**
 *  redioId
 */
@property (copy, nonatomic) NSString *radioid;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  用户信息
 */
@property (retain, nonatomic) UserInfo *userInfo;
@end
