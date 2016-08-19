//
//  ReadingPageWriteTableViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
#import "ReadingPageWriteModel.h"
@interface ReadingPageWriteTableViewCell : BSTableViewCell
/**
 *  标题
 */
@property(nonatomic, retain) UILabel *titleLabel;
/**
 *  详情
 */
@property(nonatomic, retain) UILabel *contentLabel;
/**
 *  线
 */
@property(nonatomic, retain) UIView *lineView;

@property(nonatomic, retain) ReadingPageWriteModel *readingPageWriteModel;

@end
