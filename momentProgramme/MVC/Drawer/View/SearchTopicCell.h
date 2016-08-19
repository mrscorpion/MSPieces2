//
//  SearchTopicCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class SearchTopicModel;

@interface SearchTopicCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *desc;
@property (retain, nonatomic) SearchTopicModel *cellContent;
@property (retain, nonatomic) IBOutlet UILabel *title;
@end
