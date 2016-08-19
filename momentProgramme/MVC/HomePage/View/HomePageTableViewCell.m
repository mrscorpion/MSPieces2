//
//  HomePageTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/20.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HomePageTableViewCell.h"
#import "AutoSize.h"
@implementation HomePageTableViewCell
- (void)dealloc{
//    [_type release];
//    [_typeOne release];
//    [_image release];
//    [_title release];
//    [_content release];
//    [_likeButton release];
//    [_likeNumber release];
//    [_lineView release];
//    [super dealloc];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.type = [[UILabel alloc] init];
        [self.contentView addSubview:_type];
//        [_type release];
        
        self.typeOne = [[UILabel alloc] init];
        [self.contentView addSubview:_typeOne];
//        [_typeOne release];
        
        self.image = [[UIImageView alloc] init];
        [self.image setTag:88888];
        [self.contentView addSubview:_image];
//        [_image release];
        
        self.title = [[UILabel alloc] init];
        [self.contentView addSubview:self.title];
//        [self.title release];
        
        
        self.content = [[UILabel alloc] init];
        self.content.numberOfLines = 0;
        [self.contentView addSubview:self.content];
//        [self.content release];
        
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.likeButton setBackgroundImage:[UIImage imageNamed:@"Pieces_Like"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.likeButton];
        
        
        self.likeNumber = [[UILabel alloc] init];
        [self.contentView addSubview:self.likeNumber];
//        [self.likeNumber release];
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
        [self.contentView addSubview:self.lineView];
//        [self.lineView release];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.type.frame = CGRectMake(20, 20, (kCellHeight - 40) / 3, 20);
    NSString *imageStr = _homePageModel.coverimg_wh;
    if (imageStr.length > 0) {
        NSArray *widthAndHeight = [imageStr componentsSeparatedByString:@"*"];
        CGFloat imageSale = [widthAndHeight[1] floatValue] / [widthAndHeight[0] floatValue];
        CGFloat imageHeight = imageSale * (kCellWidth - 40);
        self.image.frame = CGRectMake(20, self.type.height + self.type.y + 20, kCellWidth - 40, imageHeight);
    } else{
        self.image.frame = CGRectMake(20, self.type.height + self.type.y + 20, kCellWidth - 40, (kCellWidth - 40) / 2);
    }

    
    self.title.frame = CGRectMake(20, self.image.height + self.image.y + 20, self.image.width, 30);
    
    CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:_homePageModel.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 40];
    
    self.content.frame = CGRectMake(20, self.title.height + self.title.y + 20, self.title.width, contentHeight);
    self.likeButton.frame = CGRectMake(kCellWidth - 40 - 60, self.content.height + self.content.y + 20, 20, 20);
    self.likeNumber.frame = CGRectMake(kCellWidth - 40 - 30, self.likeButton.y, 40, 20);
    self.lineView.frame = CGRectMake(0, kCellHeight - 1, kCellWidth, 1);
    
    
}

- (void)setHomePageModel:(HomePageModel *)homePageModel{
    if (_homePageModel != homePageModel) {
//        [_homePageModel release];
//        _homePageModel = [homePageModel retain];
    }
    self.type.text = [NSString stringWithFormat:@"%@ %@",homePageModel.name , homePageModel.enname];
    self.type.textColor = [UIColor grayColor];
    self.type.font = [UIFont systemFontOfSize:11];
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:homePageModel.coverimg]placeholderImage:[UIImage imageNamed:@"RectanglePlaceholder-1"]];
    self.title.text = homePageModel.title;
    self.title.font = [UIFont systemFontOfSize:20 weight:0.3];
    
    self.content.text = homePageModel.content;
    self.content.textColor = [UIColor grayColor];
    self.content.font = [UIFont systemFontOfSize:15];
    
    self.likeNumber.text = [NSString stringWithFormat:@"%@",homePageModel.like];
    self.likeNumber.textColor = [UIColor grayColor];
    self.likeNumber.font = [UIFont systemFontOfSize:15];
    
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
