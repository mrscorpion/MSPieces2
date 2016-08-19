//
//  StreamKitHandle.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "StreamKitHandle.h"
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MediaPlayer.h>
#import "UserInfo.h"
#import "PlayInfo.h"
@interface StreamKitHandle ()<STKAudioPlayerDelegate>

@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) NSTimer *configPlayingInfoTimer;
@property (nonatomic, copy) NSString *configPlayingInfoImageUrl;
@property (nonatomic, retain) NSData *configPlayingInfoImageData;
@end

@implementation StreamKitHandle


+ (StreamKitHandle *)shareStreamKitHandle{
    static StreamKitHandle *streamHandle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        streamHandle = [[StreamKitHandle alloc] initWithAnPlayer];
    });
    return streamHandle;
}


- (instancetype)initWithAnPlayer{
    self = [super init];
    if (self) {
        self.radioPlayTyep = RadioPlayTypeCircle;
        self.playArray = [NSMutableArray array];
        self.playModelArray = [NSMutableArray array];
        self.player = [[STKAudioPlayer alloc] initWithOptions:(STKAudioPlayerOptions){ .flushQueueOnSeek = YES, .enableVolumeMixer = YES, .equalizerBandFrequencies = {50, 100, 200, 400, 800, 1600, 2600, 16000}}];
        self.player.delegate = self;
        self.player.volume = 0.6;
        self.player.meteringEnabled = YES;
    }
    return self;
}

- (void)setRadioUrlStringArray:(NSMutableArray *)radioUrlStringArray{
    [_playArray removeAllObjects];
    self.playArray = radioUrlStringArray;
    self.currentPlayNumber = 0;
    if (_playArray.count) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(track) userInfo:nil repeats:YES];
    }
}


- (void)progressBlock:(progressBlock)block{
    // Q3: ToDo Cast of block pointer type 'progress Block'   Cast of C pointer type 'void *' to block pointer type
//    _progressBlock = Block_copy(block);
}

- (void)finishBlock:(finishBlock)block{
    // Q3: ToDo Cast of block pointer type 'progress Block'   Cast of C pointer type 'void *' to block pointer type
//    _finishBlock = Block_copy(block);
}

- (void)endTimer{
    [self.timer invalidate];
}
- (void)track{
    CGFloat progressNumber = self.player.progress / self.player.duration;
    //当前时长进度progress
    NSInteger proMin = (NSInteger)self.player.progress / 60;//当前秒
    NSInteger proSec = (NSInteger)self.player.progress % 60;//当前分钟
    
    //duration 总时长
    NSInteger durMin = (NSInteger)self.player.duration / 60;//总秒
    NSInteger durSec = (NSInteger)self.player.duration % 60;//总分钟
    
    NSString *currentTimeString = [NSString stringWithFormat:@"%02ld:%02ld", proMin, proSec];
    NSString *allTimeString = [NSString stringWithFormat:@"%02ld:%02ld", durMin, durSec];
    if (self.progressBlock) {
        self.progressBlock(currentTimeString, allTimeString, progressNumber);
    }
}

- (void)beginPlayWithUrlString:(NSString *)urlString{
    for (NSInteger i = 0; i < _playArray.count; i++) {
        if ([urlString isEqualToString:[_playArray objectAtIndex:i]]) {
            _currentPlayNumber = i;
            break;
        }
    }
    self.currentPlayInfo = [_playModelArray[_currentPlayNumber] playinfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DrawerRadioChange" object:self userInfo:@{@"radioInfo" : _currentPlayInfo}];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayOrPause" object:self userInfo:@{@"PlayOrPause" : @"按钮变暂停"}];
    [self.player play:urlString];
}

- (void)stopPlay{
    [self.player stop];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayOrPause" object:self userInfo:@{@"PlayOrPause" : @"按钮变开始"}];
}


- (void)pause{
    [self.player pause];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayOrPause" object:self userInfo:@{@"PlayOrPause" : @"按钮变开始"}];
}

- (void)resume{
    [self.player resume];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayOrPause" object:self userInfo:@{@"PlayOrPause" : @"按钮变暂停"}];
}

- (void)playLast{
    switch (_radioPlayTyep) {
        case RadioPlayTypeCircle:{
            //循环播放
            _currentPlayNumber--;
            if (_currentPlayNumber < 0) {
                _currentPlayNumber = _playArray.count - 1;
            }
            break;
        }
        case RadioPlayTypeRandom:{
            //随机播放
            NSInteger arcNumber = arc4random()%_playArray.count;
            _currentPlayNumber =  arcNumber >= 0 ? arcNumber : 0;
            break;
        }
        case RadioPlayTypeSingle:{
            //单曲循环
            break;
        }
    }
    [self beginPlayWithUrlString:_playArray[_currentPlayNumber]];
}

- (void)playNext{
    switch (_radioPlayTyep) {
        case RadioPlayTypeCircle:{
            //循环播放
            _currentPlayNumber++;
            if (_currentPlayNumber > _playArray.count - 1) {
                _currentPlayNumber = 0;
            }
            break;
        }
        case RadioPlayTypeRandom:{
            //随机播放
            NSInteger arcNumber = arc4random()%_playArray.count;
            _currentPlayNumber =  arcNumber >= 0 ? arcNumber : 0;
            break;
        }
        case RadioPlayTypeSingle:{
            //单曲循环
            break;
        }
    }
    [self beginPlayWithUrlString:_playArray[_currentPlayNumber]];
}

- (void)beginConfigPlayingInfoTimer{
    self.configPlayingInfoTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(configPlayingInfo) userInfo:nil repeats:YES];
}

- (void)endConfigPlayingInfoTimer{
    [self.configPlayingInfoTimer invalidate];
}

- (void)configPlayingInfo{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    //音乐剩余时长
    [dic setObject:[NSNumber numberWithDouble:self.player.duration] forKey:MPMediaItemPropertyPlaybackDuration];
    //    //音乐当前播放时间 在计时器中修改
    [dic setObject:[NSNumber numberWithDouble:self.player.progress] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    [dic setObject:_currentPlayInfo.title forKey:MPMediaItemPropertyTitle];//歌曲名设置
    [dic setObject:_currentPlayInfo.authorInfo.uname forKey:MPMediaItemPropertyArtist];//歌手名设置
    if (_currentPlayInfo.imgUrl != self.configPlayingInfoImageUrl) {
        dispatch_queue_t queue = dispatch_get_global_queue(0 , 0);
        dispatch_async(queue, ^{
            NSString *imgUrl = _currentPlayInfo.imgUrl;
            NSData *temp= [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
            self.configPlayingInfoImageData = temp;
            if (temp) {
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                [dic setObject:_currentPlayInfo.title forKey:MPMediaItemPropertyTitle];//歌曲名设置
                [dic setObject:_currentPlayInfo.authorInfo.uname forKey:MPMediaItemPropertyArtist];//歌手名设置
                [dic setObject:[NSNumber numberWithDouble:self.player.duration] forKey:MPMediaItemPropertyPlaybackDuration];
                [dic setObject:[NSNumber numberWithDouble:self.player.progress] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
                
                [dic setObject:[[MPMediaItemArtwork alloc] initWithImage:[UIImage imageWithData:temp]] forKey:MPMediaItemPropertyArtwork];//专辑图片设置
                [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
                self.configPlayingInfoImageUrl = imgUrl;
            }
        });
    } else{
        [dic setObject:[[MPMediaItemArtwork alloc] initWithImage:[UIImage imageWithData:self.configPlayingInfoImageData]] forKey:MPMediaItemPropertyArtwork];//专辑图片设置
    }
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
}
     
/// Raised when an item has started playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didStartPlayingQueueItemId:(NSObject*)queueItemId{
//    NSLog(@"开始播放");
}
/// Raised when an item has finished buffering (may or may not be the currently playing item)
/// This event may be raised multiple times for the same item if seek is invoked on the player
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject*)queueItemId{
//    NSLog(@"完成缓冲");
}
/// Raised when the state of the player has changed
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState{
//    NSLog(@"播放状态改变");
}
/// Raised when an item has finished playing
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer didFinishPlayingQueueItemId:(NSObject*)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration{
    if (self.finishBlock) {
        self.finishBlock(stopReason);
        //    NSLog(@"完成播放");
    }
}
/// Raised when an unexpected and possibly unrecoverable error has occured (usually best to recreate the STKAudioPlauyer)
-(void) audioPlayer:(STKAudioPlayer*)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode{
    
}

//静静方法
- (void)beginPlayJingJing:(NSString *)urlString{
    if (_timer) {
        [self endTimer];
    }
    [self.player pause];
    self.currentPlayInfo = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"JingJingClean" object:self userInfo:@{@"JingJingClean" : @"clean"}];
    [self.player play:urlString];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:self selector:@selector(track) userInfo:nil repeats:YES];
}

- (void)endPlayJingJing{
    [self.player stop];
    [self endTimer];
}


@end
