//
//  PlayRadioCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PlayRadioCell.h"
#import "RedioDetailListModel.h"
#import "PlayInfo.h"
#import "UserInfo.h"

@implementation PlayRadioCell


- (void)setCellContent:(RedioDetailListModel *)cellContent{
    if (_cellContent != cellContent) {
//        [_cellContent release];
//        _cellContent = [cellContent retain];
    }
    [self.title setText:_cellContent.title];
    [self.author setText:[NSString stringWithFormat:@"by: %@", _cellContent.playinfo.authorInfo.uname]];
}

- (void)dealloc {
//    [_cellContent release];
//    [_happyView release];
//    [_title release];
//    [_author release];
//    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    if (self.isSelected) {
        [self.happyView setBackgroundColor:[UIColor blackColor]];
    } else{
       [self.happyView setBackgroundColor:[UIColor whiteColor]];
    }
}
@end
