//
//  ReadingPageWriteImageTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageWriteImageTableViewCell.h"

@implementation ReadingPageWriteImageTableViewCell


- (void)setReadingPageWriteModel:(ReadingPageWriteModel *)readingPageWriteModel{
    if (_readingPageWriteModel != readingPageWriteModel) {
//        [_readingPageWriteModel release];
//        _readingPageWriteModel = [readingPageWriteModel retain];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:readingPageWriteModel.firstimage]placeholderImage:[UIImage imageNamed:@"RectanglePlaceholder-1"]];
    self.titleLabel.text = readingPageWriteModel.title;
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:0.5];
    self.detailsLabel.text = readingPageWriteModel.shortcontent;
    self.detailsLabel.textColor = [UIColor colorWithWhite:0.408 alpha:1.000];
    
    
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
