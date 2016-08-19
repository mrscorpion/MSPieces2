//
//  HomePageTableViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
#import "HomePageModel.h"
@interface HomePageTableViewCell : BSTableViewCell
/**
 *  类型
 */
@property(nonatomic, retain) UILabel *type;
/**
 *  英文类型
 */
@property(nonatomic, retain) UILabel *typeOne;
/**
 *  图片
 */
@property(nonatomic, retain) UIImageView *image;
/**
 *  标题
 */
@property(nonatomic, retain) UILabel *title;
/**
 *  内容
 */
@property(nonatomic, retain) UILabel *content;
/**
 *  喜欢按钮
 */
@property(nonatomic, retain) UIButton *likeButton;
/**
 *  喜欢数量
 */
@property(nonatomic, retain) UILabel *likeNumber;
@property(nonatomic, retain) UIView *lineView;
@property(nonatomic, retain) HomePageModel *homePageModel;
@end
