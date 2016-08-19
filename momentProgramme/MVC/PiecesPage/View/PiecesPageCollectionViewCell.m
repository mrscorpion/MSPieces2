//
//  PiecesPageCollectionViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageCollectionViewCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@implementation PiecesPageCollectionViewCell
- (void)dealloc{
//    [_image release];
//    [_colorView release];
//    [_title release];
//    [_number release];
//    [super dealloc];
    
}


- (instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
//        [_image release];
        
        
        self.colorView = [[UIView alloc] init];
        [self.image addSubview:_colorView];
        self.colorView.backgroundColor = [UIColor colorWithWhite:0.096 alpha:0.5];
//        [_colorView release];
        
        
        self.title = [[UILabel alloc] init];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.colorView addSubview:_title];
//        [_title release];
        
        
        self.number = [[UILabel alloc] init];
        self.number.textAlignment = NSTextAlignmentCenter;
        [self.colorView addSubview:_number];
//        [_number release];
        
        
    }
    return self;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    self.image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.colorView.frame = CGRectMake(0, 0, self.image.frame.size.width, self.image.frame.size.height);
    self.title.frame = CGRectMake(0, (self.frame.size.width - 20) / 2, self.frame.size.width, 13);
    self.number.frame = CGRectMake(0, self.title.frame.origin.y + 13 , self.frame.size.width, 13);
    
}

- (void)setPiecesPageLabelModel:(PiecesPageLabelModel *)piecesPageLabelModel{
    if (_piecesPageLabelModel != piecesPageLabelModel) {
//        [_piecesPageLabelModel release];
//        _piecesPageLabelModel = [piecesPageLabelModel retain];
    }
    [self.image sd_setImageWithURL:[NSURL URLWithString:piecesPageLabelModel.img]placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    self.title.text = piecesPageLabelModel.tag;
    self.title.font = [UIFont systemFontOfSize:11];
    self.title.textColor = [UIColor whiteColor];
    self.number.text = [NSString stringWithFormat:@"%@条",piecesPageLabelModel.count];
    self.number.font = [UIFont systemFontOfSize:11];
    self.number.textColor = [UIColor whiteColor];
}


@end
