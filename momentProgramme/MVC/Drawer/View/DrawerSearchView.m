//
//  DrawerSearchView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "DrawerSearchView.h"

@implementation DrawerSearchView

- (void)dealloc
{
//    [_searchIcon release];
//    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.searchButton setBackgroundColor:[UIColor colorWithWhite:0.302 alpha:1.000]];
        [self.searchButton setFrame:CGRectMake(20, 10, frame.size.width - 40, 30)];
        [self.searchButton.layer setMasksToBounds:YES];
        [self.searchButton.layer setCornerRadius:50 / 3];
        [self addSubview:_searchButton];
        
        self.searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 6, 18, 18)];
        [self.searchIcon setImage:[UIImage imageNamed:@"searchIcon"]];
        [self.searchIcon setBackgroundColor:[UIColor clearColor]];
        [self.searchButton addSubview:_searchIcon];
//        [_searchIcon release];   
    }
    return self;
}

@end
