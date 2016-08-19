//
//  ReadingLoopsModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface ReadingLoopsModel : BSModel
/**
 *  轮播图图片
 */
@property(nonatomic, copy) NSString *img;
/**
 *  轮播图网址
 */
@property(nonatomic, copy) NSString *url;
/**
 *  故事图片
 */
@property(nonatomic, copy) NSString *coverimg;
/**
 *  故事别名
 */
@property(nonatomic, copy) NSString *enname;
/**
 *  故事名字
 */
@property(nonatomic, copy) NSString *name;
/**
 *  故事类型
 */
@property(nonatomic, copy) NSString *type;

+(ReadingLoopsModel *)readingLoopsModelWithDictionary:(NSDictionary *)dic;
@end
