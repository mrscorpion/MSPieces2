//
//  QualityPageModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "QualityPageModel.h"

@implementation QualityPageModel
- (void)dealloc{
//    [_buyurl release];
//    [_contentid release];
//    [_coverimg release];
//    [_title release];
//    [super dealloc];
}

- (instancetype) initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
