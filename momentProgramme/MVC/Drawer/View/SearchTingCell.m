//
//  SearchTingCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchTingCell.h"
#import "SearchTingModel.h"
#import "UserInfo.h"

@implementation SearchTingCell

- (void)setCellContent:(SearchTingModel *)cellContent{
    if (_cellContent != cellContent) {
//        [_cellContent release];
//        _cellContent = [cellContent retain];
    }
    [self.radioImage sd_setImageWithURL:[NSURL URLWithString:_cellContent.firstimage] placeholderImage:[UIImage imageNamed:@"RadioPlaceHolder"]];
    [self.author setText:_cellContent.userInfo.uname];
    [self.title setText:_cellContent.title];
}


- (void)dealloc {
//    [_cellContent release];
//    [_radioImage release];
//    [_author release];
//    [_title release];
//    [super dealloc];
}
@end
