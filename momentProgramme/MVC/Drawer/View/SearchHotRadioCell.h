//
//  SearchHotRadioCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class HotSearch;

@interface SearchHotRadioCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) HotSearch *cellModel;
@end
