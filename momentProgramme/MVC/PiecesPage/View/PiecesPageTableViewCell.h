//
//  PiecesPageTableViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
#import "PiecesPageModel.h"
@interface PiecesPageTableViewCell : BSTableViewCell
/**
 *  头像
 */
@property(nonatomic, retain)UIImageView *photoImage;
@property(nonatomic, retain)UIButton *photoButton;
/**
 *  名字
 */
@property(nonatomic, retain)UILabel *name;
/**
 *  发布时间
 */
@property(nonatomic, retain)UILabel *time;
/**
 *  发表图片
 */
@property(nonatomic, retain)UIImageView *image;
/**
 *  发表内容
 */
@property(nonatomic, retain)UILabel *contentLabel;
/**
 *  喜欢按钮
 */
@property(nonatomic, retain)UIButton *likeButton;
/**
 *  喜欢数量
 */
@property(nonatomic, retain) UILabel *likeNumber;

@property(nonatomic, retain) UIView *lineView;
@property(nonatomic, retain) PiecesPageModel *piecesPageModel;




@end
