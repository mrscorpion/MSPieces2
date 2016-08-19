//
//  PiecesPageLabelModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface PiecesPageLabelModel : BSModel
/**
 *  动态数量
 */
@property(nonatomic, copy) NSString *count;
/**
 *  图片
 */
@property(nonatomic, copy) NSString *img;
/**
 *  标题
 */
@property(nonatomic , copy) NSString *tag;




@end
