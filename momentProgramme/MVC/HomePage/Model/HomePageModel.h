//
//  HomePageModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class PlayInfo;

@interface HomePageModel : BSModel
/**
 *  详情
 */
@property(nonatomic, copy) NSString *content;
/**
 *  图片
 */
@property(nonatomic, copy) NSString *coverimg;
/**
 *  英文类型
 */
@property(nonatomic, copy) NSString *enname;
/**
 *  id
 */
@property(nonatomic, copy) NSString *ID;
/**
 *  喜欢数量
 */
@property(nonatomic, copy) NSString *like;
/**
 *  类型名字
 */
@property(nonatomic, copy) NSString *name;
/**
 *  标题
 */
@property(nonatomic, copy) NSString *title;
/**
 *  类型
 */
@property(nonatomic, copy) NSNumber *type;
/**
 *  图片宽高
 */
@property(nonatomic, copy) NSString *coverimg_wh;
/**
 *  日期
 */
@property(nonatomic, copy) NSString *date;
/**
 *  电台
 */
@property(nonatomic, retain) PlayInfo *playinfo;

@property(nonatomic, retain) NSDictionary *userinfo;

@end
