//
//  ReadingDetailsModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface ReadingDetailsModel : BSModel
/**
 *  内容摘要
 */
@property(nonatomic, copy) NSString *content;
/**
 *  图片
 */
@property(nonatomic, copy) NSString *coverimg;
/**
 *  ID
 */
@property(nonatomic, copy) NSString *ID;
/**
 *  名字
 */
@property(nonatomic, copy) NSString *name;
/**
 *  标题
 */
@property(nonatomic, copy) NSString *title;

+(ReadingDetailsModel *)readingDetailsModelWithDictionary:(NSDictionary *)dic;


@end
