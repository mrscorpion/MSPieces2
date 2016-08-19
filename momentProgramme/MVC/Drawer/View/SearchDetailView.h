//
//  SearchDetailView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"

@protocol SearchDetailViewDelegate <NSObject>

- (void)pushAViewController:(UIViewController *)viewController;

@end

@interface SearchDetailView : BSView
@property (nonatomic, retain) NSArray *allDetailArray;
@property (assign, nonatomic) id<SearchDetailViewDelegate> delegate;
@property (copy ,nonatomic) NSString *searchWord;
@end
