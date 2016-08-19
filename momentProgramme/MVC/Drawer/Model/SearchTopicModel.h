//
//  SearchTopicModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"


@interface SearchTopicModel : BSModel
/*
 "title": "你慢慢说，我静静听",
 "shortcontent": "阿嬷说，夏天的绿豆羹，要用冰镇过的才好吃。那时候，我家有一口古老的井。井的四周都布满了青苔。阿嬷说那...",
 "userinfo": {},
 "contentid": "523965157f8b9adb03000030",
 "addtime_f": "2013-9-18 16:32"
 */



/**
*  内容id
*/
@property (copy, nonatomic) NSString *contentid;
/**
*  简介
*/
@property (copy, nonatomic) NSString *shortcontent;
/**
*  标题
*/
@property (copy, nonatomic) NSString *title;
@end
