//
//  SearchUserCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchUserCell.h"
#import "UserInfo.h"

@implementation SearchUserCell

- (void)setCellContent:(UserInfo *)cellContent{
    if (_cellContent != cellContent) {
//        [_cellContent release];
//        _cellContent = [cellContent retain];
    }
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:_cellContent.icon] placeholderImage:[UIImage imageNamed:@"userPlaceHolder"]];
    [self.author setText:_cellContent.uname];
}

- (void)dealloc {
//    [_cellContent release];
//    [_userIcon release];
//    [_author release];
//    [super dealloc];
}
@end
