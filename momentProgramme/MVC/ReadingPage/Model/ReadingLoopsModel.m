//
//  ReadingLoopsModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingLoopsModel.h"

@implementation ReadingLoopsModel
- (void)dealloc{
//    [_img release];
//    [_url release];
//    [_coverimg release];
//    [_name release];
//    [_enname release];
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

+ (ReadingLoopsModel *)readingLoopsModelWithDictionary:(NSDictionary *)dic{
    ReadingLoopsModel *reading = [[ReadingLoopsModel alloc]initWithDictionary:dic];
//    return [reading autorelease];
    return reading;
    
    
    
}




@end
