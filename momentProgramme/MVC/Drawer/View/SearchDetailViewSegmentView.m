//
//  SearchDetailViewSegmentView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchDetailViewSegmentView.h"
//25000 +3

@interface SearchDetailViewSegmentView ()
@property (retain, nonatomic) UIView *happyView;
@property (retain, nonatomic) UIView *redHappyView;
@end

@implementation SearchDetailViewSegmentView
- (void)dealloc
{
//    [_titleContentArray release];
//    [_redHappyView release];
//    [_happyView release];
//    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat buttonWidth = frame.size.width / 4;
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *segmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [segmentButton setTag:25000 + i];
            [segmentButton addTarget:self action:@selector(segmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [segmentButton setTitle:@"全部 \n 1--" forState:UIControlStateNormal];
            [segmentButton.titleLabel setNumberOfLines:2];
            [segmentButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [segmentButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            if (i == 0) {
                [segmentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            } else{
                [segmentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [segmentButton setFrame:CGRectMake(i * buttonWidth, 0, buttonWidth, frame.size.height)];
            [self addSubview:segmentButton];
        }
        self.happyView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, frame.size.width, 1)];
        [self.happyView setBackgroundColor:[UIColor colorWithWhite:0.929 alpha:1.000]];
        [self addSubview:_happyView];
//        [_happyView release];
        
        self.redHappyView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height, buttonWidth, 2)];
        [self.redHappyView setBackgroundColor:[UIColor redColor]];
        [self addSubview:_redHappyView];
//        [_redHappyView release];
    }
    return self;
}

- (void)setTitleContentArray:(NSArray *)titleContentArray{
    if (_titleContentArray != titleContentArray) {
//        [_titleContentArray release];
//        _titleContentArray = [titleContentArray retain];
    }
    for (NSInteger i = 25000; i < 25004; i++) {
        UIButton *buttonAll = [self viewWithTag:i];
        [buttonAll setTitle:_titleContentArray[i - 25000] forState:UIControlStateNormal];
    }
}

- (void)segmentButtonAction:(UIButton *)button{
    [UIView animateWithDuration:0.2 animations:^{
        [self.redHappyView setFrame:CGRectMake(button.x, kViewHeight, button.width, 2)];
    }];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *buttonAll = [self viewWithTag:25000 + i];
        [buttonAll setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_delegate selectButton:button.tag - 25000];
}

@end
