//
//  PiecesPageLabelModel.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageLabelModel.h"

@implementation PiecesPageLabelModel
- (void)dealloc{
//    [_count release];
//    [_img release];
//    [_tag release];
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
