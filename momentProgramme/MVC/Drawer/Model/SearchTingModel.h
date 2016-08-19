//
//  SearchTingModel.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class UserInfo;
@class PlayInfo;

@interface SearchTingModel : BSModel
//"tingid": "535097748ead0eba4e00001f",
//"firstimage": "http://pianke.image.alimmdn.com/upload/20140416/8b32c81f00e87cc1898dc7654d1eefa8.JPG",
//"title": "你可以听过就忘记",
//"addtime_f": "2014-4-18 00:00",
//"userinfo": {},
//"playInfo": {}

@property (copy, nonatomic) NSString *firstimage;
@property (copy, nonatomic) NSString *title;
@property (retain, nonatomic) UserInfo *userInfo;
@property (retain, nonatomic) PlayInfo *playinfo;


@end
