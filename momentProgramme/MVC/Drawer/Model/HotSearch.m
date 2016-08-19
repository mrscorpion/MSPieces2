//
//  HotSearch.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HotSearch.h"
#import "PlayInfo.h"

@implementation HotSearch

- (void)dealloc
{
//    [_title release];
//    [_playinfo release];
//    [_contentid release];
//    [_type release];
//    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"playInfo"]) {
        self.playinfo = [[PlayInfo alloc] initWithDictionary:value];
    }
}

@end
