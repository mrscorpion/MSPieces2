//
//  SearchTingModel.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchTingModel.h"
#import "PlayInfo.h"
#import "UserInfo.h"

@implementation SearchTingModel

- (void)dealloc
{
//    [_firstimage release];
//    [_title release];
//    [_userInfo release];
//    [_playinfo release];
//    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:value];
        self.userInfo = userInfo;
//        [userInfo release];
    } else if ([key isEqualToString:@"playInfo"]){
        PlayInfo *playinfo = [[PlayInfo alloc] initWithDictionary:value];
        self.playinfo = playinfo;
//        [playinfo release];
    }
}

@end
