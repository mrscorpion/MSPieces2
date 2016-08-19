//
//  SearchViewTableViewHeader.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/30.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchViewTableViewHeader.h"

@implementation SearchViewTableViewHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 45)];
        [self.label setBackgroundColor:[UIColor colorWithWhite:0.980 alpha:1.000]];
        [self.label setFont:[UIFont systemFontOfSize:15]];
        [self.label setTextColor:[UIColor colorWithWhite:0.431 alpha:1.000]];
        [self addSubview:_label];
        UIView *happyView = [[UIView alloc] initWithFrame:CGRectMake(8, 44, _label.width - 8, 1)];
        [happyView setBackgroundColor:[UIColor colorWithWhite:0.749 alpha:1.000]];
        [self addSubview:happyView];
//        [happyView release];
//        [_label release];
    }
    return self;
}


@end
