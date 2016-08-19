//
//  SearchHotRadioCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchHotRadioCell.h"
#import "HotSearch.h"


@implementation SearchHotRadioCell

- (void)setCellModel:(HotSearch *)cellModel{
    if (_cellModel != cellModel) {
//        [_cellModel release];
//        _cellModel = [cellModel retain];
    }
    [self.title setText:_cellModel.title];
}

- (void)dealloc {
//    [_cellModel release];
//    [_title release];
//    [super dealloc];
}
@end
