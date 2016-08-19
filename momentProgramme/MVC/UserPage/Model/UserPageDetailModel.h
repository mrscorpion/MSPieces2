//
//  UserPageDetailModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class PlayInfo;

@interface UserPageDetailModel : BSModel
/**
 *  添加时间
 */
@property (copy, nonatomic) NSString *addtime_f;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  内容label显示的内容
 */
@property (copy, nonatomic) NSString *content;
/**
 *  动态类型
 */
@property (retain, nonatomic) NSNumber *type;
/**
 *  图片的宽高 例子100*100
 */
@property (copy, nonatomic) NSString *coverimg_wh;
/**
 *  图片啊~~~
 */
@property (copy, nonatomic) NSString *coverimg;
/**
 *  文章跳转的id
 */
@property (copy, nonatomic) NSString *contentid;
/**
 *  如果有radio就存在这个属性
 */
@property (retain, nonatomic) PlayInfo *playinfo;
@end
