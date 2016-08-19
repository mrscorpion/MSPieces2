//
//  RedioDetailListModel.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioDetailListModel.h"
#import "PlayInfo.h"


@implementation RedioDetailListModel

- (void)dealloc
{
//    [_coverimg release];
//    [_musicUrl release];
//    [_musicVisit release];
//    [_tingid release];
//    [_title release];
//    [_playinfo release];
//    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"playInfo"]) {
        PlayInfo *playInfo = [[PlayInfo alloc] initWithDictionary:value];
        self.playinfo = playInfo;
//        [playInfo release];
    }
}
@end
