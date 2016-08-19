//
//  ReadingCollectionViewCell.h
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadingLoopsModel.h"
@interface ReadingCollectionViewCell : UICollectionViewCell
@property(nonatomic, retain) UIImageView *image;
@property(nonatomic, retain) UILabel *name;
@property(nonatomic, retain) UILabel *enname;
@property(nonatomic, retain) UIImageView *backgroundImage;
@property(nonatomic, retain) ReadingLoopsModel *readingLoops;



@end
