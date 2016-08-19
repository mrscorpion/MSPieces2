//
//  FHYNavigationBar.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/13.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSView.h"

typedef CF_ENUM (NSInteger,  LeftButtonType) {
    LeftButtonDrawerType = 0,
    LeftButtonBackType
};

@protocol FHYNavigationBarDelegate <NSObject>
//点击左侧按钮
- (void)selectedLeftButton:(UIButton *)leftButton;


@end

@interface FHYNavigationBar : BSView
@property (assign, nonatomic) id<FHYNavigationBarDelegate> delegate;
@property (assign, nonatomic) BOOL showUnderLine;
@property (retain, nonatomic) UIButton *leftButton;
@property (retain, nonatomic) NSArray *rightButtonArray;
@property (retain, nonatomic) UILabel *titleLabel;

//以Bar宽度,左侧按钮类型(返回类型,呼出抽屉类型),右侧按钮数组(需为每个Button设置Tag),和TitleLabel的内容初始化
- (instancetype)initWithWidth:(CGFloat)width LeftButtonType:(LeftButtonType)type andRightButtons:(NSArray *)buttons andTitleName:(NSString *)titleName;
- (void)setShowUnderLine:(BOOL)showUnderLine;
//滑动条
- (void)scrollUnderLineToButton:(UIButton *)button;

- (void)setTitle:(NSString *)title;
@end
