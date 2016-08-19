//
//  PlayRadioViewController.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "CustomViewController.h"
@class PlayInfo;
@interface PlayRadioViewController : CustomViewController
@property (retain, nonatomic)PlayInfo *detailPlayInfo;


- (void)setRadioListArrayToPlayer:(NSMutableArray *)radioListArray;
@end
