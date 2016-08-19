//
//  QualityPageModel.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface QualityPageModel : BSModel
/**
 *  淘宝跳转网址
 */
@property(nonatomic, copy) NSString *buyurl;
/**
 *  id
 */
@property(nonatomic, copy) NSString *contentid;
@property(nonatomic, copy) NSString *coverimg;
@property(nonatomic, copy) NSString *title;


@end
