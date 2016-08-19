//
//  PiecesPageTableViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageTableViewCell.h"
#import "AutoSize.h"

@implementation PiecesPageTableViewCell
- (void)dealloc{
//    [_photoImage release];
//    [_photoButton release];
//    [_name release];
//    [_time release];
//    [_image release];
//    [_contentLabel release];
//    [_likeButton release];
//    [_likeNumber release];
//    [_lineView release];
//    [super dealloc];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.photoButton];
        
        self.photoImage = [[UIImageView alloc] init];
        [self.photoButton addSubview:_photoImage];
        self.photoImage.layer.masksToBounds = YES;
        self.photoImage.layer.cornerRadius = 15;
//        [_photoImage release];
        
        
        self.name = [[UILabel alloc] init];
        [self.contentView addSubview:_name];
//        [_name release];
        
        self.time = [[UILabel alloc] init];
        self.time.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_time];
//        [_time release];
        
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
//        [_image release];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentLabel];
//        [_contentLabel release];
        
        self.likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_likeButton];
        [self.likeButton setImage:[UIImage imageNamed:@"Pieces_Like"] forState:UIControlStateNormal];

        self.likeNumber = [[UILabel alloc] init];
        [self.contentView addSubview:_likeNumber];
//        [_likeNumber release];
        
        
        self.lineView = [[UIView alloc] init];
        self.lineView.backgroundColor = [UIColor colorWithWhite:0.859 alpha:1.000];
        [self.contentView addSubview:_lineView];
//        [_lineView release];
        
        
    }
    return self;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.photoButton.frame = CGRectMake(20, 20, 30, 30);
    self.photoImage.frame = CGRectMake(0, 0, 30, 30);
    self.name.frame = CGRectMake(70, 20,( self.frame.size.width - 40) / 2, 30);
    self.time.frame = CGRectMake(kCellWidth - 100, self.name.frame.origin.y, 80, 30);
    
    if (_piecesPageModel.coverimg_wh.length != 0 && _piecesPageModel.content.length != 0) {
        
        NSArray *widthAndHeight = [_piecesPageModel.coverimg_wh componentsSeparatedByString:@"*"];
        CGFloat hh = [widthAndHeight[1] floatValue]/ [widthAndHeight[0] floatValue];
        CGFloat height = hh * (self.frame.size.width - 40);
        
        
        self.image.frame = CGRectMake(20, self.photoButton.frame.size.height + self.photoButton.frame.origin.y + 20, kCellWidth - 40, height);
        
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:_piecesPageModel.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 40];
       
        
        self.contentLabel.frame = CGRectMake(20, self.image.frame.size.height + self.image.frame.origin.y + 20, self.image.frame.size.width, contentHeight);
        
        
        
        
    }else if (_piecesPageModel.coverimg_wh.length != 0 && _piecesPageModel.content.length == 0){
        
        
        NSArray *widthAndHeight = [_piecesPageModel.coverimg_wh componentsSeparatedByString:@"*"];
        CGFloat hh = [widthAndHeight[1] floatValue]/ [widthAndHeight[0] floatValue];
        CGFloat height = hh * (self.frame.size.width - 40);
        
        
        
        
        self.image.frame = CGRectMake(20, self.photoButton.frame.size.height + self.photoButton.frame.origin.y + 20, kCellWidth - 40, height);
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:_piecesPageModel.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 40];
        
        self.contentLabel.frame = CGRectMake(20, self.image.frame.size.height + self.image.frame.origin.y + 20, 0, contentHeight);
        
        
    }else{
        
        self.image.frame = CGRectMake(20, self.photoButton.frame.size.height + self.photoButton.frame.origin.y + 20 ,0, 0);
        
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:_piecesPageModel.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kCellWidth - 40];
        
        self.contentLabel.frame = CGRectMake(20, self.image.frame.size.height + self.image.frame.origin.y , self.frame.size.width - 40, contentHeight);
    }
    
    
    self.likeButton.frame = CGRectMake(kCellWidth - 20 - 50, self.contentLabel.frame.size.height + self.contentLabel.frame.origin.y + 10, 20, 20);
    
    
    
    self.likeNumber.frame = CGRectMake(self.likeButton.frame.size.width + self.likeButton.frame.origin.x + 10, self.likeButton.frame.origin.y, 40, 20);
    
    self.lineView.frame = CGRectMake(0, kCellHeight - 1, kCellWidth, 1);
    
   
}

- (void)setPiecesPageModel:(PiecesPageModel *)piecesPageModel{
    NSLog(@"%f",kCellWidth);
    if (_piecesPageModel != piecesPageModel) {
//        [_piecesPageModel release];
//        _piecesPageModel = [piecesPageModel retain];
    }
    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:[_piecesPageModel.userinfo objectForKey:@"icon"]] placeholderImage:[UIImage imageNamed:@"userPlaceHolder"]];
    

    
    self.name.text = [_piecesPageModel.userinfo objectForKey:@"uname"];
    self.name.textColor = [UIColor colorWithRed:0.224 green:0.294 blue:0.408 alpha:1.000];
    self.name.font = [UIFont systemFontOfSize:13];
    
    self.time.text = _piecesPageModel.addtime_f;
    self.time.textColor = [UIColor grayColor];
    self.time.font = [UIFont systemFontOfSize:12];
    
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:_piecesPageModel.coverimg] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    
    self.contentLabel.text = _piecesPageModel.content;
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    
    self.likeNumber.text = [NSString stringWithFormat:@"%@",[_piecesPageModel.counterList objectForKey:@"like"]];
    self.likeNumber.textColor = [UIColor grayColor];
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
