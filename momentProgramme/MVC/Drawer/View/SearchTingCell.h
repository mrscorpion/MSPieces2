//
//  SearchTingCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class SearchTingModel;

@interface SearchTingCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UIImageView *radioImage;
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) SearchTingModel *cellContent;
@end
