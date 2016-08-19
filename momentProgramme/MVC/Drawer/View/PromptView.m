//
//  PromptView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PromptView.h"
#import "PromptTableViewCell.h"
#import "PromptModel.h"

@interface PromptView ()<UITableViewDataSource,UITableViewDelegate>
@property (retain, nonatomic) UITableView *promptTableView;
@end

@implementation PromptView
- (void)dealloc
{
//    [_promptTableView release];
//    [_contentArray release];
//    [super dealloc];
}

- (void)setContentArray:(NSArray *)contentArray{
    if (_contentArray != contentArray) {
//        [_contentArray release];
//        _contentArray = [contentArray retain];
    }
    [self.promptTableView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.promptTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) style:UITableViewStylePlain];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBg"]];
        [self.promptTableView setBackgroundView:bgImageView];
        [self.promptTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
        [self.promptTableView setDelegate:self];
        [self.promptTableView setDataSource:self];
        self.promptTableView.showsHorizontalScrollIndicator = NO;
        self.promptTableView.showsVerticalScrollIndicator = NO;
        [self.promptTableView registerNib:[UINib nibWithNibName:@"PromptTableViewCell" bundle:nil] forCellReuseIdentifier:@"PromptTableViewCell"];
        [self addSubview:_promptTableView];
//        [_promptTableView release];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArray.count ? _contentArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PromptModel *temp = _contentArray[indexPath.row];
    PromptTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PromptTableViewCell" forIndexPath:indexPath];
    [cell setCellModel:temp];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PromptModel *temp = _contentArray[indexPath.row];
    [_delegate selectedCellWithWord:temp.name];
}

@end
