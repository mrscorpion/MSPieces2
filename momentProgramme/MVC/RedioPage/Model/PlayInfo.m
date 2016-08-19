//
//  PlayInfo.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PlayInfo.h"
#import "UserInfo.h"
@implementation PlayInfo

- (void)dealloc
{
//    [_imgUrl release];
//    [_musicUrl release];
//    [_sharepic release];
//    [_sharetext release];
//    [_shareurl release];
//    [_ting_contentid release];
//    [_tingid release];
//    [_title release];
//    [_webview_url release];
//    [_userInfo release];
//    [_authorInfo release];
//    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:value];
        self.userInfo = userInfo;
//        [userInfo release];
    } else if ([key isEqualToString:@"authorinfo"]){
        UserInfo *authorinfo = [[UserInfo alloc] initWithDictionary:value];
        self.authorInfo = authorinfo;
//        [authorinfo release];
    }
}
@end
