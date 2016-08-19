//
//  FHYNavigationBar.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/13.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "FHYNavigationBar.h"
#import "UIView+FHYAdditions.h"

@interface FHYNavigationBar ()
@property (retain, nonatomic) UIView *backGroundView;
@property (retain, nonatomic) UIView *underLine;
@end

@implementation FHYNavigationBar
- (void)dealloc
{
//    [_underLine release];
//    [_titleLabel release];
//    [_rightButtonArray release];
//    [_leftButton release];
//    [_backGroundView release];
//    [super dealloc];
}
- (instancetype)initWithWidth:(CGFloat)width LeftButtonType:(LeftButtonType)type andRightButtons:(NSArray *)buttons andTitleName:(NSString *)titleName{
    self = [super init];
    if (self) {
        self.showUnderLine = NO;
        [self setBackgroundColor:[UIColor blackColor]];
        [self setFrame:CGRectMake(0, 0, width, 64)];
        self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, width, 44)];
        [self.backGroundView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:_backGroundView];
//        [_backGroundView release];
        
        self.leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.leftButton addTarget:self action:@selector(barLeftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (type == LeftButtonBackType) {
            [self.leftButton setImage:[UIImage imageNamed:@"NavBar_Back"] forState:UIControlStateNormal];
            [self.leftButton setImage:[UIImage imageNamed:@"NavBar_Back_Selected"] forState:UIControlStateHighlighted];
            [self.leftButton setTag:11000];
        } else{
        [self.leftButton setImage:[UIImage imageNamed:@"NavBar_LeftDrawer"] forState:UIControlStateNormal];
        [self.leftButton setImage:[UIImage imageNamed:@"NavBar_LeftDrawer_Selected"] forState:UIControlStateHighlighted];
            [self.leftButton setTag:11001];
        }
        [self.leftButton setFrame:CGRectMake(11, 11, 22, 22)];
        [self.backGroundView addSubview:_leftButton];
        
        UIView *happyView = [[UIView alloc] initWithFrame:CGRectMake(0, kViewHeight - 1, kViewWidth, 1)];
        [happyView setBackgroundColor:[UIColor colorWithRed:0.929 green:0.925 blue:0.929 alpha:1.000]];
        [self addSubview:happyView];
//        [happyView release];
        
        UIView *happyViewTwo = [[UIView alloc] initWithFrame:CGRectMake(47, 20, 1, 44)];
        [happyViewTwo setBackgroundColor:[UIColor colorWithRed:0.929 green:0.925 blue:0.929 alpha:1.000]];
        [self addSubview:happyViewTwo];
//        [happyViewTwo release];
        
        if (buttons.count) {
            self.rightButtonArray = buttons;
            for (NSInteger i = buttons.count - 1; i >= 0; i--) {
                UIButton *button = [buttons objectAtIndex:i];
                [button setFrame:CGRectMake(width - width / 8.5 - (width / 7 - 10) * i, _leftButton.y, 22, 22)];
                [self.backGroundView addSubview:button];
            }
        }
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(happyViewTwo.right + 8, _leftButton.y, 100, 22)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.titleLabel setText:titleName];
        [self.backGroundView addSubview:_titleLabel];
//        [_titleLabel release];
        
    }
    return self;
}

- (void)setShowUnderLine:(BOOL)showUnderLine{
    if (_showUnderLine != showUnderLine) {
        _showUnderLine = showUnderLine;
    }
    if (showUnderLine) {
        self.underLine = [[UIView alloc] init];
        [self.underLine setBackgroundColor:[UIColor blackColor]];
        [self.backGroundView addSubview:_underLine];
//        [_underLine release];
        if (_rightButtonArray.count) {
            UIButton *firstButton = [_rightButtonArray lastObject];
            [self.underLine setFrame:CGRectMake(firstButton.x, 42, firstButton.width, 1)];
        }
    }
}

- (void)setTitle:(NSString *)title{
    [self.titleLabel setText:title];
}

- (void)scrollUnderLineToButton:(UIButton *)button;{
    if (self.showUnderLine) {
        [UIView animateWithDuration:0.1 animations:^{
            [self.underLine setFrame:CGRectMake(button.x, 42, button.width, 1)];
        }];
    }
}

- (void)barLeftButtonAction:(UIButton *)button{
    [_delegate selectedLeftButton:button];
}
@end
