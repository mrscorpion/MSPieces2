//
//  SearchDetailViewSegmentView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"

@protocol SearchDetailViewSegmentViewDelegate <NSObject>

- (void)selectButton:(NSInteger )number;

@end

@interface SearchDetailViewSegmentView : BSView
@property (assign, nonatomic) id<SearchDetailViewSegmentViewDelegate> delegate;
@property (retain, nonatomic) NSArray *titleContentArray;
- (void)segmentButtonAction:(UIButton *)button;
@end
