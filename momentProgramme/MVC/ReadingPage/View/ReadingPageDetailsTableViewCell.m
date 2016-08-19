//
//  ReadingPageDetailsTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageDetailsTableViewCell.h"

@implementation ReadingPageDetailsTableViewCell
- (void)dealloc{
//    [_titleLabel release];
//    [_image release];
//    [_detailsLabel release];
//    [_lineView release];
//    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_titleLabel];
//        [_titleLabel release];
        
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
//        [_image release];
        
        self.detailsLabel = [[UILabel alloc] init];
        self.detailsLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailsLabel];
//        [_detailsLabel release];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        [self.contentView addSubview:_lineView];
//        [_lineView release];
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 20, self.frame.size.width - 40, 20);
    self.image.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + 20, (kCellWidth - 50) / 2, (kCellWidth - 50) / 4);
    self.detailsLabel.frame = CGRectMake(self.image.frame.size.width + self.image.frame.origin.x + 10, self.image.frame.origin.y,self.frame.size.width - self.image.frame.size.width - 40 - 10, self.image.frame.size.height);
    
    self.lineView.frame = CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1);
    
    
}

-(void)setReadingDetailsModel:(ReadingDetailsModel *)readingDetailsModel{
    if (_readingDetailsModel != readingDetailsModel) {
//        [_readingDetailsModel release];
//        _readingDetailsModel = [readingDetailsModel retain];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:readingDetailsModel.coverimg]placeholderImage:[UIImage imageNamed:@"RectanglePlaceholder-1"]];
    self.titleLabel.text = readingDetailsModel.title;
    self.titleLabel.font = [UIFont systemFontOfSize:20 weight:0.5];
    self.detailsLabel.text = readingDetailsModel.content;
    self.detailsLabel.textColor = [UIColor grayColor];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
