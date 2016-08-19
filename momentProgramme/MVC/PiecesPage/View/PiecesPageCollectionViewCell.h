//
//  PiecesPageCollectionViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiecesPageLabelModel.h"
@interface PiecesPageCollectionViewCell : UICollectionViewCell
/**
 *  图片
 */
@property(nonatomic, retain) UIImageView *image;
/**
 *  透明背景色
 */
@property(nonatomic, retain) UIView *colorView;
/**
 *  标题
 */
@property(nonatomic, retain) UILabel *title;
/**
 *  动态数量
 */
@property(nonatomic, retain) UILabel *number;
@property(nonatomic, retain) PiecesPageLabelModel *piecesPageLabelModel;


@end
