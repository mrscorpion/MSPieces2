//
//  ReadingCollectionViewCell.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingCollectionViewCell.h"
#import <SDWebImageManager.h>
#import <UIImageView+WebCache.h>
@implementation ReadingCollectionViewCell
- (void)dealloc{
//    [_image release];
//    [_name release];
//    [_enname release];
//    [_backgroundImage release];
//    [super dealloc];
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] init];
        [self.contentView addSubview:_image];
//        [_image release];
        
        self.backgroundImage = [[UIImageView alloc] init];
        self.backgroundImage.image = [UIImage imageNamed:@"Reading_Square"];
        [self.image addSubview:_backgroundImage];
//        [_backgroundImage release];
        
        self.name = [[UILabel alloc] init];
        [self.backgroundImage addSubview:_name];
//        [_name release];
        
        self.enname = [[UILabel alloc] init];
        [self.backgroundImage addSubview:_enname];
//        [_enname release];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.image.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.backgroundImage.frame = CGRectMake(0, 0, self.image.frame.size.width, self.image.frame.size.height);
    self.name.frame = CGRectMake(5, self.frame.size.height - 30, self.frame.size.width - 10, 30);
    self.enname.frame = CGRectMake(self.name.frame.size.width + self.name.frame.origin.x, self.name.frame.origin.y, (self.frame.size.width - 10) / 5  * 2, 30);
    
    
}

-(void)setReadingLoops:(ReadingLoopsModel *)readingLoops{
    if (_readingLoops != readingLoops) {
//        [_readingLoops release];
//        _readingLoops = [readingLoops retain];
        
    }
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:readingLoops.coverimg]placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    self.name.text = [NSString stringWithFormat:@"%@%@",readingLoops.name,readingLoops.enname];
    self.name.textColor = [UIColor whiteColor];
    self.name.font = [UIFont systemFontOfSize:14];
    

    
}

@end
