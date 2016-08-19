//
//  PromptTableViewCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PromptTableViewCell.h"
#import "PromptModel.h"

@implementation PromptTableViewCell

- (void)setCellModel:(PromptModel *)cellModel{
    if (_cellModel != cellModel) {
//        [_cellModel release];
//        _cellModel = [cellModel retain];
    }
    [self.searchWord setText:_cellModel.name];
}

- (void)dealloc {
//    [_cellModel release];
//    [_searchWord release];
//    [super dealloc];
}
@end
