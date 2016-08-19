//
//  QualityPageTableViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
#import "QualityPageModel.h"
@interface QualityPageTableViewCell : BSTableViewCell
@property(nonatomic, retain) UIImageView *image;
@property(nonatomic, retain) UILabel *titleLabel;
@property(nonatomic, retain) UIButton *buyButton;
@property(nonatomic, retain) UIView *lineView;
@property(nonatomic, retain) QualityPageModel *qualityPageModel;


@end
