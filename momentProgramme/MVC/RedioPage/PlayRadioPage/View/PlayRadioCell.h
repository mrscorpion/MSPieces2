//
//  PlayRadioCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class RedioDetailListModel;
@interface PlayRadioCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UIView *happyView;
@property (retain, nonatomic) IBOutlet UILabel *title;
@property (retain, nonatomic) IBOutlet UILabel *author;
@property (retain, nonatomic) RedioDetailListModel *cellContent;
@end
