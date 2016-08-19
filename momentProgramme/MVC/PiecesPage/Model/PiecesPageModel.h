//
//  PiecesPageModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface PiecesPageModel : BSModel
/**
 *  发布时间
 */
@property(nonatomic, copy) NSString *addtime_f;
/**
 *  发布内容
 */
@property(nonatomic, copy) NSString *content;
/**
 *  id
 */
@property(nonatomic, copy) NSString *contentid;
/**
 *  喜欢数量
 */
@property(nonatomic, copy) NSString *like;
/**
 *  发布图片
 */
@property(nonatomic, copy) NSString *coverimg;
/**
 *  图片宽高
 */
@property(nonatomic, copy) NSString *coverimg_wh;
/**
 *  头像图片
 */
@property(nonatomic, copy) NSString *icon;
/**
 *  作者id
 */
@property(nonatomic, copy) NSString *uid;
/**
 *  作者名字
 */
@property(nonatomic, copy) NSString *uname;

@property(nonatomic, retain)NSDictionary *userinfo;

@property(nonatomic, retain)NSDictionary *counterList;


@end
