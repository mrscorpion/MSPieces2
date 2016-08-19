//
//  PiecesPageModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageModel.h"

@implementation PiecesPageModel
- (void)dealloc{
//    [_addtime_f release];
//    [_content release];
//    [_contentid release];
//    [_like release];
//    [_coverimg release];
//    [_coverimg_wh release];
//    [_icon release];
//    [_uid release];
//    [_uname release];
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
    
}


@end
