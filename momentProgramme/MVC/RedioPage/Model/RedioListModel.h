//
//  RedioListModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"

@interface RedioListModel : BSModel
//图片
@property (copy, nonatomic) NSString *coverimg;
//副标题
@property (copy, nonatomic) NSString *desc;
//标题
@property (copy, nonatomic) NSString *title;
//听众数量
@property (copy, nonatomic) NSString *count;
//redioId
@property (copy, nonatomic) NSString *radioid;
//作者名字 需要在前面拼接 by:
@property (copy, nonatomic) NSString *uname;
@end
