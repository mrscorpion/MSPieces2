//
//  ConsoleView.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"
#import "PageNumberView.h"
//Tag 17000 + 2
typedef CF_ENUM (NSInteger,  PlayButtonType) {
    PlayButtonLastType = 0,
    PlayButtonPlayType,
    PlayButtonNextType
};
@protocol ConsoleViewDelegate <NSObject>

- (void)clickedButton:(PlayButtonType)buttonType andTouchButton:(UIButton *)touchButton;

@end

@interface ConsoleView : BSView

@property (retain, nonatomic) PageNumberView *pageNumberView;
@property (assign, nonatomic) id<ConsoleViewDelegate> delegate;

@end
