//
//  ReadingPageWriteModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageWriteModel.h"

@implementation ReadingPageWriteModel
- (void)dealloc{
//    [_addtime_f release];
//    [_contentid release];
//    [_firstimage release];
//    [_shortcontent release];
//    [_title release];
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
