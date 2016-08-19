//
//  ReadingPageWriteModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface ReadingPageWriteModel : BSModel
/**
 *  时间
 */
@property(nonatomic, copy) NSString *addtime_f;
/**
 *  id
 */
@property(nonatomic, copy) NSString *contentid;
/**
 *  图片
 */
@property(nonatomic, copy) NSString *firstimage;
/**
 *  内容
 */
@property(nonatomic, copy) NSString *shortcontent;
/**
 *  标题
 */
@property(nonatomic, copy) NSString *title;



@end
