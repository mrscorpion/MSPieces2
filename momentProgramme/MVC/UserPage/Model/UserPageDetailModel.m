//
//  UserPageDetailModel.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserPageDetailModel.h"
#import "PlayInfo.h"

@implementation UserPageDetailModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"playInfo"]) {
        PlayInfo *playInfo = [[PlayInfo alloc] initWithDictionary:value];
        self.playinfo = playInfo;
    }
}

@end
