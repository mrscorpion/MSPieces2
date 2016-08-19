//
//  SearchHotTopicCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchHotTopicCell.h"
#import "HotSearch.h"

@implementation SearchHotTopicCell

- (void)setCellModel:(HotSearch *)cellModel{
    if (_cellModel != cellModel) {
//        [_cellModel release];
//        _cellModel = [cellModel retain];
    }
    [self.titile setText:_cellModel.title];
}

- (void)dealloc {
//    [_cellModel release];
//    [_titile release];
//    [super dealloc];
}
@end
