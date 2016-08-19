//
//  RedioDetailListModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class PlayInfo;
@interface RedioDetailListModel : BSModel
/**
 *  Cell图片
 */
@property (copy, nonatomic) NSString *coverimg;

/**
 *  音乐地址
 */
@property (copy, nonatomic) NSString *musicUrl;
/**
 *  听众人数
 */
@property (copy, nonatomic) NSString *musicVisit;
/**
 *  tingId用处未知
 */
@property (copy, nonatomic) NSString *tingid;

/**
 *  Cell标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  playInfo
 */
@property (retain, nonatomic) PlayInfo *playinfo;

@end
