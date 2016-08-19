//
//  DrawerViewCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "DrawerViewCell.h"
#import "UIView+FHYAdditions.h"

@interface DrawerViewCell ()
@property (retain, nonatomic) UIImageView *iconImageView;
@property (retain, nonatomic) UILabel *label;
@end
@implementation DrawerViewCell

- (void)dealloc{
//    [_iconImageView release];
//    [_label release];
//    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
        self.iconImageView = [UIImageView new];
        [self.contentView addSubview:_iconImageView];
//        [_iconImageView release];
        
        self.label = [UILabel new];
        [self.label setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:_label];
//        [_label release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_iconImageView setFrame:CGRectMake(30, 15, kCellHeight - 30 , kCellHeight - 30)];
    [_label setFrame:CGRectMake(_iconImageView.right + 30, _iconImageView.top, self.contentView.width - _iconImageView.right - 40, _iconImageView.height)];
}

- (void)setImage:(UIImage *)image andLabelText:(NSString *)viewControllerName{
    [_iconImageView setImage:image];
    [_label setText:viewControllerName];
}

//- (void)


@end
