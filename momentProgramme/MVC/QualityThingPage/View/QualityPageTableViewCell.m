//
//  QualityPageTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "QualityPageTableViewCell.h"
@implementation QualityPageTableViewCell
- (void)dealloc{
//    [_image release];
//    [_titleLabel release];
//    [_buyButton release];
//    [_lineView release];
//    [super dealloc];
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:self.image];
//        [self.image release];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
//        [self.titleLabel release];
        
        
        self.buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.buyButton.backgroundColor = [UIColor colorWithRed:0.400 green:0.667 blue:0.212 alpha:1.000];
        self.buyButton.layer.masksToBounds = YES;
        self.buyButton.layer.cornerRadius = 15;
        [self.buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [self.buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal ];
        self.buyButton.titleLabel.font = [UIFont systemFontOfSize:10];
       
        [self.contentView addSubview:self.buyButton];
        
        
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.863 alpha:1.000];
        [self.contentView addSubview:self.lineView];
//        [self.lineView release];
        
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.image.frame = CGRectMake(20, 20, kCellWidth - 40, (kCellWidth - 40) /  2);
    self.titleLabel.frame = CGRectMake(20, self.image.bottom + 20, self.image.width - 70, 30);
    self.buyButton.frame = CGRectMake(kCellWidth - 20 - 60, self.titleLabel.frame.origin.y, 60, 30);
    self.lineView.frame = CGRectMake(0, kCellHeight -1, kCellWidth, 1);
}

- (void)setQualityPageModel:(QualityPageModel *)qualityPageModel{
    if (_qualityPageModel != qualityPageModel) {
//        [_qualityPageModel release];
//        _qualityPageModel = [qualityPageModel retain];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:qualityPageModel.coverimg]placeholderImage:[UIImage imageNamed:@"RectanglePlaceholder-1"]];
    self.titleLabel.text = qualityPageModel.title;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
