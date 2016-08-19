//
//  ReadingPageDetailsTableViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
#import "ReadingDetailsModel.h"
@interface ReadingPageDetailsTableViewCell : BSTableViewCell
/**
 *  标题
 */
@property(nonatomic, retain) UILabel *titleLabel;
/**
 *  图片
 */
@property(nonatomic, retain) UIImageView *image;
/**
 *  详情
 */
@property(nonatomic, retain) UILabel *detailsLabel;
@property(nonatomic, retain) UIView *lineView;
@property(nonatomic, retain) ReadingDetailsModel *readingDetailsModel;


@end
