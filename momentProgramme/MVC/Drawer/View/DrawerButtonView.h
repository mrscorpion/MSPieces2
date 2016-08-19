//
//  DrawerButtonView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"

@protocol DrawerButtonViewDelegat <NSObject>

- (void)selectedButton:(UIButton *)button;

@end

@interface DrawerButtonView : BSView
@property (nonatomic, assign) id<DrawerButtonViewDelegat> delegate;
@end
