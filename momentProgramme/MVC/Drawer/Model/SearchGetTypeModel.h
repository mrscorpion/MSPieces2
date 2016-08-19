//
//  SearchGetTypeModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface SearchGetTypeModel : BSModel
/**
 *  搜索出来的类型  user content ting
 */
@property (copy, nonatomic) NSString *type;
/**
 *  用户 故事 Ting
 */
@property (copy, nonatomic) NSString *typename;
/**
 *  搜索结果数量
 */
@property (retain, nonatomic) NSNumber *total;
/**
 *  临时存放的数组
 */
@property (retain, nonatomic) NSArray *list;

@property (retain, nonatomic) NSMutableArray *getList;
@end
