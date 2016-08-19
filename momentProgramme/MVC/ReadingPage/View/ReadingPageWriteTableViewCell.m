//
//  ReadingPageWriteTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageWriteTableViewCell.h"

@implementation ReadingPageWriteTableViewCell
- (void)dealloc{
//    [_titleLabel release];
//    [_contentLabel release];
//    [_lineView release];
//    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.titleLabel];
//        [self.titleLabel release];
        
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
//        [self.contentLabel release];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.855 alpha:1.000];
        [self.contentView addSubview:self.lineView];
//        [self.lineView release];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 20, self.frame.size.width - 40, 30);
    self.contentLabel.frame = CGRectMake(20, self.titleLabel.frame.size.height + 30, self.titleLabel.frame.size.width, self.frame.size.height - self.titleLabel.frame.size.height - 40 );
    self.lineView.frame = CGRectMake(20, self.frame.size.height - 1, self.frame.size.width - 40, 1);
}

- (void)setReadingPageWriteModel:(ReadingPageWriteModel *)readingPageWriteModel{
    if (_readingPageWriteModel != readingPageWriteModel) {
//        [_readingPageWriteModel release];
//        _readingPageWriteModel = [readingPageWriteModel retain];
    }
    self.titleLabel.text = readingPageWriteModel.title;
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:0.5];
    self.contentLabel.text = readingPageWriteModel.shortcontent;
    self.contentLabel.textColor = [UIColor colorWithWhite:0.408 alpha:1.000];

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
