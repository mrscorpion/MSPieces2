//
//  RedioDetailListCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioDetailListCell.h"

#import "RedioDetailListModel.h"

@interface RedioDetailListCell ()
@property (retain, nonatomic) IBOutlet UIImageView *cellImageView;
@property (retain, nonatomic) IBOutlet UILabel *cellTitle;
@property (retain, nonatomic) IBOutlet UILabel *cellNumber;


@end
@implementation RedioDetailListCell

- (void)setDetailListModel:(RedioDetailListModel *)detailListModel{
    if (_detailListModel != detailListModel) {
//        [_detailListModel release];
//        _detailListModel = [detailListModel retain];
    }
    [_cellImageView sd_setImageWithURL:[NSURL URLWithString:_detailListModel.coverimg] placeholderImage:[UIImage imageNamed:@"RadioPlaceHolder"]];
    [_cellTitle setText:_detailListModel.title];
    [_cellNumber setText:[NSString stringWithFormat:@"♪ %@",_detailListModel.musicVisit]];
}

- (void)dealloc {
//    [_cellImageView release];
//    [_cellTitle release];
//    [_cellNumber release];
//    [super dealloc];
}


@end
