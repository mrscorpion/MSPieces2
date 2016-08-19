//
//  SearchHotTopicCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class HotSearch;

@interface SearchHotTopicCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *titile;
@property (retain, nonatomic) HotSearch *cellModel;
@end
