//
//  StreamKitHandle.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <STKAudioPlayer.h>
#import "RedioDetailListModel.h"

/**
 歌曲播放形式
 */
typedef enum : NSInteger {
    RadioPlayTypeCircle,  //循环播放
    RadioPlayTypeRandom,  //随机播放
    RadioPlayTypeSingle,//单曲循环
} RadioPlayType;

typedef void(^progressBlock)(NSString *currentTime, NSString *allTime, CGFloat progress);
typedef void(^finishBlock)(STKAudioPlayerStopReason stopReason);

@interface StreamKitHandle : NSObject

@property (nonatomic, retain) STKAudioPlayer *player;
@property (nonatomic, retain) NSMutableArray *playArray;//传入的musicUrl数组
@property (nonatomic, retain) NSMutableArray *playModelArray;//传入的Model数组
@property (nonatomic, assign) RadioPlayType radioPlayTyep;
@property (assign, nonatomic) NSInteger currentPlayNumber;
@property (retain, nonatomic) PlayInfo *currentPlayInfo;
@property (copy, nonatomic) progressBlock progressBlock;
@property (copy, nonatomic) finishBlock finishBlock;

+ (StreamKitHandle *)shareStreamKitHandle;

- (void)setRadioUrlStringArray:(NSMutableArray *)radioUrlStringArray;

- (void)progressBlock:(progressBlock)block;
- (void)finishBlock:(finishBlock)block;

- (void)beginPlayWithUrlString:(NSString *)urlString;
- (void)stopPlay;
- (void)pause;
- (void)resume;
- (void)playLast;
- (void)playNext;

- (void)endTimer;


//后台播放更新计时器开启
- (void)beginConfigPlayingInfoTimer;
- (void)endConfigPlayingInfoTimer;
//后台播放更新计时器停止
//静静的方法如下
/*
 //开始播放
 [[StreamKitHandle shareStreamKitHandle] beginPlayJingJing:@"testUrlString"];
 //更新剩余时间
 [[StreamKitHandle shareStreamKitHandle] progressBlock:^(NSString *currentTime, NSString *allTime, CGFloat progress) {
 NSString *lastTime = [currentTime substringFromIndex:2];
 NSInteger lastDate = 60 - [lastTime integerValue];
 NSString *labelText = [NSString stringWithFormat:@"%ld",lastDate];
 NSLog(@"当前播放剩余时间%@",labelText);
 }];
 //结束静静播放
 [[StreamKitHandle shareStreamKitHandle] endPlayJingJing];
 */
- (void)beginPlayJingJing:(NSString *)urlString;
- (void)endPlayJingJing;

@end
