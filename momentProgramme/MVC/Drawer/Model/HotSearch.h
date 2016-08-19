//
//  HotSearch.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class PlayInfo;

@interface HotSearch : BSModel
/**
 *  文章内容ID
 */
@property (copy, nonatomic) NSString *contentid;
/**
 *  显示的标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  类型
 */
@property (retain, nonatomic) NSNumber *type;
/**
 *  如果有radio存在
 */
@property (retain, nonatomic) PlayInfo *playinfo;
@end
