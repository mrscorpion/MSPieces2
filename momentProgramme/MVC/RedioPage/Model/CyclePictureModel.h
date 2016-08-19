//
//  CyclePictureModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface CyclePictureModel : BSModel
//图片地址
@property (copy, nonatomic) NSString *img;
//提供的URL 需要截取后面的字段
@property (copy, nonatomic) NSString *url;
@end
