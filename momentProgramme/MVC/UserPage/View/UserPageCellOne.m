//
//  UserPageCellOne.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserPageCellOne.h"
#import "UserPageDetailModel.h"
#import "AutoSize.h"


@interface UserPageCellOne ()
@property (retain, nonatomic) UILabel *addTime;
@property (retain, nonatomic) UILabel *poOneInfo;
@property (retain, nonatomic) UILabel *content;
@property (retain, nonatomic) UIView *happyView;
@end

@implementation UserPageCellOne

- (void)dealloc {
//    [_happyView release];
//    [_detailModel release];
//    [_addTime release];
//    [_poOneInfo release];
//    [_pic release];
//    [_content release];
//    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.addTime = [[UILabel alloc] init];
        [self.addTime setTextColor:[UIColor colorWithWhite:0.784 alpha:1.000]];
        [self.addTime setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:_addTime];
//        [_addTime release];
        
        self.poOneInfo = [[UILabel alloc] init];
        [self.poOneInfo setTextColor:[UIColor colorWithWhite:0.784 alpha:1.000]];
        [self.poOneInfo setTextAlignment:NSTextAlignmentRight];
        [self.poOneInfo setText:@"发布了一个碎片"];
        [self.poOneInfo setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:_poOneInfo];
//        [_poOneInfo release];
        
        self.pic = [[UIImageView alloc] init];
        [self.pic setTag:77777];
        [self.contentView addSubview:_pic];
//        [_pic release];
        
        self.content = [[UILabel alloc]init];
        [self.content setTextColor:[UIColor blackColor]];
        [self.content setFont:[UIFont systemFontOfSize:15]];
        [self.content setNumberOfLines:0];
        [self.contentView addSubview:_content];
//        [_content release];
        
        self.happyView = [[UIView alloc] init];
        [self.happyView setBackgroundColor:[UIColor colorWithWhite:0.749 alpha:1.000]];
        [self.contentView addSubview:_happyView];
//        [_happyView release];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = [AutoSize AutoSizeOfHeightWithText:_detailModel.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 40];
    [self.addTime setFrame:CGRectMake(20, 8, kCellWidth / 2 - 20, 15)];
    [self.poOneInfo setFrame:CGRectMake(kCellWidth / 2, 8, kCellWidth / 2 - 20, 15)];
    if (_detailModel.coverimg.length > 0) {
        NSArray *widthAndHeight = [_detailModel.coverimg_wh componentsSeparatedByString:@"*"];
        CGFloat width = [[widthAndHeight objectAtIndex:0] floatValue];
        CGFloat height = [[widthAndHeight objectAtIndex:1] floatValue];
        CGFloat mul = height / width;
        [self.pic setFrame:CGRectMake(_addTime.x, _addTime.bottom + 20, kCellWidth - 40, (kCellWidth - 40) * mul)];
    } else{
        [self.pic setFrame:CGRectMake(_addTime.x, _addTime.bottom + 20, kCellWidth - 40, 0)];
    }
    [self.content setFrame:CGRectMake(_pic.x, _pic.bottom + 10, kCellWidth - 40, height)];
    
    [self.happyView setFrame:CGRectMake(_content.x - 12, self.contentView.bottom - 1, kCellWidth - 8, 1)];
}

- (void)setDetailModel:(UserPageDetailModel *)detailModel{
    if (_detailModel != detailModel) {
//        [_detailModel release];
//        _detailModel = [detailModel retain];
    }
    [self.addTime setText:_detailModel.addtime_f];
    if (_detailModel.coverimg.length > 0) {
        [self.pic sd_setImageWithURL:[NSURL URLWithString:_detailModel.coverimg] placeholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];
    }
    [self.content setText:_detailModel.content];
}

@end
