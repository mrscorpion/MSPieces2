//
//  SearchTopicCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchTopicCell.h"
#import "SearchTopicModel.h"

@implementation SearchTopicCell

- (void)setCellContent:(SearchTopicModel *)cellContent{
    if (_cellContent != cellContent) {
//        [_cellContent release];
//        _cellContent = [cellContent retain];
    }
    [self.title setText:_cellContent.title];
    [self.desc setText:_cellContent.shortcontent];
}


- (void)dealloc {
//    [_cellContent release];
//    [_title release];
//    [_desc release];
//    [super dealloc];
}
@end
