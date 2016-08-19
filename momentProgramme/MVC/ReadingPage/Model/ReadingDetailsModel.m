//
//  ReadingDetailsModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingDetailsModel.h"

@implementation ReadingDetailsModel
- (void)dealloc{
//    [_ID release];
//    [_content release];
//    [_coverimg release];
//    [_name release];
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

+ (ReadingDetailsModel *)readingDetailsModelWithDictionary:(NSDictionary *)dic{
    ReadingDetailsModel *details = [[ReadingDetailsModel alloc] initWithDictionary:dic];
//    return [details autorelease];
    return details;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
