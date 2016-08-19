//
//  RedioListCell.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioListCell.h"
#import "RedioListModel.h"

@interface RedioListCell ()
@property (retain, nonatomic) IBOutlet UIImageView *redioImageView;
@property (retain, nonatomic) IBOutlet UILabel *redioTitle;
@property (retain, nonatomic) IBOutlet UILabel *redioAuthor;
@property (retain, nonatomic) IBOutlet UILabel *redioSubTitle;
@property (retain, nonatomic) IBOutlet UILabel *redioListenCount;


@end
@implementation RedioListCell

- (void)setCellContent:(RedioListModel *)cellContent{
    if (_cellContent != cellContent) {
//        [_cellContent release];
//        _cellContent = [cellContent retain];
    }
    [self.redioImageView sd_setImageWithURL:[NSURL URLWithString:_cellContent.coverimg] placeholderImage:[UIImage imageNamed:@"RadioPlaceHolder"]];
    [self.redioTitle setText:_cellContent.title];
    [self.redioSubTitle setText:_cellContent.desc];
    [self.redioAuthor setText:[NSString stringWithFormat:@"by:%@",_cellContent.uname]];
    [self.redioListenCount setText:[NSString stringWithFormat:@"♪ %@",_cellContent.count]];
}

- (void)dealloc {
//    [_redioImageView release];
//    [_redioTitle release];
//    [_redioAuthor release];
//    [_redioSubTitle release];
//    [_redioListenCount release];
//    [super dealloc];
}
@end
