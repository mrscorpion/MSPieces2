//
//  RedioHotListCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
//12000 + 2  Tag值
@protocol RedioHotListCellDelegate <NSObject>

- (void)selectedOneHotListButton:(UIButton *)hotButton;

@end

@interface RedioHotListCell : BSTableViewCell
@property (assign, nonatomic) id<RedioHotListCellDelegate> delegate;
- (void)setImageArray:(NSArray *)array;
@end
