//
//  RedioListModel.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioListModel.h"

@implementation RedioListModel

- (void)dealloc
{
//    [_coverimg release];
//    [_desc release];
//    [_title release];
//    [_count release];
//    [_radioid release];
//    [_uname release];
//    [super dealloc];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"userinfo"]) {
        self.uname = [value objectForKey:@"uname"];
    }
}
@end
