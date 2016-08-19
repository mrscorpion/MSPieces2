//
//  PromptView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"

@protocol PromptViewDelegate <NSObject>

- (void)selectedCellWithWord:(NSString *)word;

@end

@interface PromptView : BSView
@property (retain, nonatomic) NSArray *contentArray;
@property (assign, nonatomic) id<PromptViewDelegate> delegate;
@end
