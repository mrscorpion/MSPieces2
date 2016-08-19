//
//  PlayAuthorView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PlayAuthorView.h"
#import "UserInfo.h"

@interface PlayAuthorView ()
@property (retain, nonatomic) IBOutlet UILabel *radioAuthorName;
@property (retain, nonatomic) IBOutlet UILabel *authorName;

@end

@implementation PlayAuthorView

- (void)setRadioAuthorInfo:(UserInfo *)radioAuthorInfo{
    if (_radioAuthorInfo != radioAuthorInfo) {
//        [_radioAuthorInfo release];
//        _radioAuthorInfo = [radioAuthorInfo retain];
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0 , 0);
    dispatch_async(queue, ^{
        NSData *temp= [NSData dataWithContentsOfURL:[NSURL URLWithString:_radioAuthorInfo.icon]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.radioAuthorButton setBackgroundImage:[UIImage imageWithData:temp] forState:UIControlStateNormal];
        });
    });
    
    [self.radioAuthorName setText:_radioAuthorInfo.uname];
}

- (void)setAuthorInfo:(UserInfo *)authorInfo{
    if (_authorInfo != authorInfo) {
//        [_authorInfo release];
//        _authorInfo = [authorInfo retain];
    }
    dispatch_queue_t queue = dispatch_get_global_queue(0 , 0);
    dispatch_async(queue, ^{
        NSData *temp= [NSData dataWithContentsOfURL:[NSURL URLWithString:_authorInfo.icon]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.authorButton setBackgroundImage:[UIImage imageWithData:temp] forState:UIControlStateNormal];
        });
    });
    [self.authorName setText:_authorInfo.uname];
}

- (void)dealloc {
//    [_radioAuthorInfo release];
//    [_authorInfo release];
//    [_radioAuthorButton release];
//    [_authorButton release];
//    [_radioAuthorName release];
//    [_authorName release];
//    [super dealloc];
}
@end
