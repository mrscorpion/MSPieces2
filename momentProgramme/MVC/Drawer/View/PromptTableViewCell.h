//
//  PromptTableViewCell.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSTableViewCell.h"
@class PromptModel;
@interface PromptTableViewCell : BSTableViewCell
@property (retain, nonatomic) IBOutlet UILabel *searchWord;
@property (retain, nonatomic) PromptModel *cellModel;

@end
