//
//  RedioDetailHeaderView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"
@class RadioListInfoModel;
@interface RedioDetailHeaderView : BSView
@property (nonatomic, retain)RadioListInfoModel *radioListInfo;
@property (retain, nonatomic) IBOutlet UIButton *userIcon;

@end
