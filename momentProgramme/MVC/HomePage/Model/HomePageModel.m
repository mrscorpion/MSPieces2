//
//  HomePageModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HomePageModel.h"
#import "playInfo.h"

@implementation HomePageModel
- (void)dealloc{
//    [_playinfo release];
//    [_content release];
//    [_coverimg release];
//    [_enname release];
//    [_ID release];
//    [_like release];
//    [_name release];
//    [_title release];
//    [_type release];
//    [super dealloc];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
        
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
        
    } else if ([key isEqualToString:@"playInfo"]){
        PlayInfo *playInfo = [[PlayInfo alloc] initWithDictionary:value];
        self.playinfo = playInfo;
//        [playInfo release];
    }
}

@end
