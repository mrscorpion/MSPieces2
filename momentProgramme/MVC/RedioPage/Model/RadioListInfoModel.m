//
//  RadioListInfoModel.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RadioListInfoModel.h"
#import "UserInfo.h"
@implementation RadioListInfoModel
- (void)dealloc
{
//    [_coverimg release];
//    [_desc release];
//    [_musicvisitnum release];
//    [_radioid release];
//    [_title release];
//    [_userInfo release];
//    [super dealloc];
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:value];
        self.userInfo = userInfo;
//        [userInfo release];
    }
}

@end
