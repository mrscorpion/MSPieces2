//
//  RedioHotListCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioHotListCell.h"
#import <UIButton+WebCache.h>
#import "RedioHotlistModel.h"
@interface RedioHotListCell ()
@property (retain, nonatomic) UILabel *nextSectionTitle;
@property (retain, nonatomic) UIView *happyView;
@end

@implementation RedioHotListCell
- (void)dealloc
{
//    [_happyView release];
//    [_nextSectionTitle release];
//    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor colorWithWhite:0.980 alpha:1.000]];
        for (NSInteger i = 0; i < 3; i++) {
            UIButton *hotButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [hotButton setAdjustsImageWhenHighlighted:NO];
            [hotButton setBackgroundColor:[UIColor cyanColor]];
            [hotButton addTarget:self action:@selector(hotButton:) forControlEvents:UIControlEventTouchUpInside];
            [hotButton setTag:12000 + i];
            [self addSubview:hotButton];
        }
        
        self.nextSectionTitle = [[UILabel alloc] init];
        [self.nextSectionTitle setText:@"全部电台 • All Redios"];
        [self.nextSectionTitle setFont:[UIFont systemFontOfSize:13]];
        [self.nextSectionTitle setTextColor:[UIColor colorWithWhite:0.784 alpha:1.000]];
        [self addSubview:_nextSectionTitle];
//        [_nextSectionTitle release];
        
        self.happyView = [UIView new];
        [self.happyView setBackgroundColor:[UIColor colorWithWhite:0.878 alpha:1.000]];
        [self addSubview:_happyView];
//        [_happyView release];
    }
    return self;
}

- (void)hotButton:(UIButton *)hotButton{
    [_delegate selectedOneHotListButton:hotButton];
}

- (void)setImageArray:(NSArray *)array{
    for (NSInteger i = 0; i < 3; i++) {
        RedioHotlistModel *temp = array[i];
        NSURL *tempUrl = [NSURL URLWithString:temp.coverimg];
        UIButton *hotButton = [self viewWithTag:12000 + i];
        [hotButton sd_setImageWithURL:tempUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];
    }
}

- (void)layoutSubviews{
    CGFloat hotButtonWidth = (kCellWidth - 8 * 2 - 5 * 2) / 3;
    for (NSInteger i = 0; i < 3; i++) {
        UIButton *hotButton = [self viewWithTag:12000 + i];
        [hotButton setFrame:CGRectMake(8 + i * (hotButtonWidth + 5), 8, hotButtonWidth, hotButtonWidth)];
    }
    
    [self.nextSectionTitle setFrame:CGRectMake(8, 16 + hotButtonWidth, 130, 20)];
    [self.happyView setFrame:CGRectMake(_nextSectionTitle.right + 5, _nextSectionTitle.y + 10, kCellWidth - _nextSectionTitle.y - 8, 1)];
}

@end
