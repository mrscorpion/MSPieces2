//
//  PlayRadioViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PlayRadioViewController.h"

#import "StreamKitHandle.h"
#import "PlayInfo.h"
#import "RedioDetailListModel.h"
#import "UserInfo.h"

#import "ConsoleView.h"
#import "PlayAuthorView.h"
#import "PlayView.h"

#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>

#import "PlayRadioCell.h"
#import "UserViewController.h"


@interface PlayRadioViewController ()<UIWebViewDelegate,UIScrollViewDelegate,NJKWebViewProgressDelegate,PlayViewDelegate,ConsoleViewDelegate>
@property (retain, nonatomic) UIScrollView *backGroundScrollView;
@property (retain, nonatomic) NSMutableArray *radioList;
@property (retain, nonatomic) NSMutableArray *buttonsArray;
@property (retain, nonatomic) PlayView *playView;
@property (retain, nonatomic) ConsoleView *consoleView;
@property (retain, nonatomic) UITableView *radioTableView;
@property (retain, nonatomic) PlayAuthorView *authorView;
@property (retain, nonatomic) UIWebView *radioWebView;
@property (retain, nonatomic) NJKWebViewProgressView *webViewProgressView;
@property (retain, nonatomic) NJKWebViewProgress *webViewProgress;
@property (retain, nonatomic) NSTimer *stopTimer;
@end

@implementation PlayRadioViewController

- (void)dealloc
{
//    [_playView release];
//    [_webViewProgress release];
//    [_webViewProgressView release];
//    [_authorView release];
//    [_radioWebView release];
//    [_radioTableView release];
//    [_consoleView release];
//    [_buttonsArray release];
//    [_radioList release];
//    [_backGroundScrollView release];
//    [_detailPlayInfo release];
//    [super dealloc];
}

- (void)viewDidDisappear:(BOOL)animated{
   [super viewDidDisappear:animated];
    [[StreamKitHandle shareStreamKitHandle] endTimer];
    [self.radioWebView setDelegate:nil];
 
}
//将点击时传入的播放信息处理,并根据PlayInfo开始进入音乐播放处理
- (void)setDetailPlayInfo:(PlayInfo *)detailPlayInfo{
    if (_detailPlayInfo != detailPlayInfo) {
//        [_detailPlayInfo release];
//        _detailPlayInfo = [detailPlayInfo retain];
    }
    __block typeof(self) weakSelf = self;
    //处理类中计时器执行每秒更新方法时调用的block 回传回当前时间,全部时间,和进度比例
    [[StreamKitHandle shareStreamKitHandle] progressBlock:^(NSString *currentTime, NSString *allTime, CGFloat progress) {
        if (weakSelf) {
            if (weakSelf.playView) {
                [weakSelf.playView setCurrentTime:currentTime andAllTime:allTime andProgress:progress];
            }
        }
    }];
    //结束播放一曲后播放下一曲
    [[StreamKitHandle shareStreamKitHandle] finishBlock:^(STKAudioPlayerStopReason stopReason) {
        if (weakSelf) {
            if (stopReason == STKAudioPlayerStopReasonEof) {
                [[StreamKitHandle shareStreamKitHandle] playNext];
                if (weakSelf)  [weakSelf changeOtherViewsInfo];
            }
        }
    }];
    
}

//将列表也同时传入VC中,为下一曲播放等做准备,并把数据处理后,将URLString数组传入播放器处理类
- (void)setRadioListArrayToPlayer:(NSMutableArray *)radioListArray{
    self.radioList = radioListArray;
    [[StreamKitHandle shareStreamKitHandle] setPlayModelArray:_radioList];
    NSMutableArray *radioUrlStringArray = [NSMutableArray array];
    for (RedioDetailListModel *temp in _radioList) {
        [radioUrlStringArray addObject:temp.musicUrl];
    }
    [[StreamKitHandle shareStreamKitHandle] setRadioUrlStringArray:radioUrlStringArray];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化右上角按钮数组
    [self initButtonsArray];
    //创建NavigationBar
    [self createNavigationBar:LeftButtonBackType andRightButtons:_buttonsArray andTitleName:_detailPlayInfo.title];
    [self.customNavigationBar setShowUnderLine:YES];
    //创建音乐控制台
    [self createConsoleView];
    //创建scrollView
    [self createAScrollView];
    //创建左右轻扫手势
    [self createSwipeGesture];
    //创建一个TableView
    [self createATableView];
    //创建一个playView
    [self createAPlayView];
    //创建一个WebView
    [self createAWebView];
    //创建一个主播和原文view
    [self createAAuthorView];
    //开始播放当前的音乐
    if (![[StreamKitHandle shareStreamKitHandle].currentPlayInfo.tingid isEqualToString:_detailPlayInfo.tingid]) {
        [[StreamKitHandle shareStreamKitHandle] beginPlayWithUrlString:self.detailPlayInfo.musicUrl];
    }
}

- (void)initButtonsArray{
    self.buttonsArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:13000 + i];
        if (i == 0) {
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Play_Type_%ld", [StreamKitHandle shareStreamKitHandle].radioPlayTyep]] forState:UIControlStateNormal];
        } else{
            if (i == 1) {
                BOOL isCollected = [self searchFromCoreDataWithEntityName:RadioModelType andIndentifier:_detailPlayInfo.tingid];
                if (isCollected) {
                    [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
                } else{
                    [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
                }
            } else{
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Play_%ld",i]] forState:UIControlStateNormal];
            }
        }
        [btn addTarget:self action:@selector(rightButtonsAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonsArray insertObject:btn atIndex:0];
    }
}

- (void)rightButtonsAction:(UIButton *)btn{
    [self.customNavigationBar scrollUnderLineToButton:btn];
    switch (btn.tag) {
        case 13000:{
            RadioPlayType newType = [StreamKitHandle shareStreamKitHandle].radioPlayTyep == RadioPlayTypeSingle ? RadioPlayTypeCircle : [StreamKitHandle shareStreamKitHandle].radioPlayTyep + 1;
            [[StreamKitHandle shareStreamKitHandle] setRadioPlayTyep:newType];
            [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"Play_Type_%ld", [StreamKitHandle shareStreamKitHandle].radioPlayTyep]] forState:UIControlStateNormal];
            break;
        }
        case 13001:
            if ([[btn backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Play_1"]]) {
                [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
//                [self insertEntityToCoreDataWithEntityName:RadioModelType andObject:[_detailPlayInfo retain]];
                [self insertEntityToCoreDataWithEntityName:RadioModelType andObject:_detailPlayInfo];
            } else {
                [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
//                [self deleteEntityObjectWithObject:[_detailPlayInfo retain] andEntityName:RadioModelType];
                [self deleteEntityObjectWithObject:_detailPlayInfo andEntityName:RadioModelType];
            }
            break;
        case 13002:
            //分享
            [self shareWithContent:[NSString stringWithFormat:@"我正在EosWing App倾听电台:%@", self.customNavigationBar.titleLabel.text] andButton:btn];
            break;
        case 13003:
            btn.selected = !btn.isSelected;
            if ([[[self.consoleView viewWithTag:17001] backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"PlayButton_1_Pause"]] && btn.isSelected) {
                [SVProgressHUD showImage:[UIImage imageNamed:@"Play_3"] status:@"十分钟后关闭歌曲"];
                self.stopTimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(pauseRadio) userInfo:nil repeats:NO];
            } else {
                if ([[[self.consoleView viewWithTag:17001] backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"PlayButton_1_Pause"]]) {
                    [SVProgressHUD showImage:[UIImage imageNamed:@"Play_3"] status:@"定时关闭取消"];
                } else{
                    [SVProgressHUD showImage:[UIImage imageNamed:@"Play_3"] status:@"还没有开始播放"];
                }
                [self.stopTimer invalidate];
            }
            break;
        default:
            break;
    }
}
- (void)pauseRadio{
    [[self.consoleView viewWithTag:17001] setBackgroundImage:[UIImage imageNamed:@"PlayButton_1"] forState:UIControlStateNormal];
    [[StreamKitHandle shareStreamKitHandle] pause];
    
}
//音乐控制台
- (void)createConsoleView{
    self.consoleView = [[ConsoleView alloc]initWithFrame:CGRectMake(0, kHeight - 90, kWidth, 90)];
    [self.consoleView setDelegate:self];
    [self.view addSubview:_consoleView];
//    [_consoleView release];
}
- (void)clickedButton:(PlayButtonType)buttonType andTouchButton:(UIButton *)touchButton{
    switch (buttonType) {
        case PlayButtonLastType:
            [[StreamKitHandle shareStreamKitHandle] playLast];
            [self changeOtherViewsInfo];
            break;
        case PlayButtonPlayType:
            if ([[touchButton backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"PlayButton_1_Pause"]]) {
                [touchButton setBackgroundImage:[UIImage imageNamed:@"PlayButton_1"] forState:UIControlStateNormal];
                [[StreamKitHandle shareStreamKitHandle] pause];
            } else{
                [touchButton setBackgroundImage:[UIImage imageNamed:@"PlayButton_1_Pause"] forState:UIControlStateNormal];
                [[StreamKitHandle shareStreamKitHandle] resume];
            }
            break;
        case PlayButtonNextType:
            [[StreamKitHandle shareStreamKitHandle] playNext];
            [self changeOtherViewsInfo];
            break;
        default:
            break;
    }
}
//在改变歌曲时候改变其他
- (void)changeOtherViewsInfo{
    NSInteger currentPlayNumber = [StreamKitHandle shareStreamKitHandle].currentPlayNumber;
    //换歌之后 webView改变,作者栏改变 ,歌曲改变
    RedioDetailListModel *temp = [_radioList objectAtIndex:currentPlayNumber];
    self.detailPlayInfo = temp.playinfo;
    UIButton *btn = [self.customNavigationBar viewWithTag:13001];
    BOOL isCollected = [self searchFromCoreDataWithEntityName:RadioModelType andIndentifier:_detailPlayInfo.tingid];
    if (isCollected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
    } else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
    }
    [self.radioTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:currentPlayNumber inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.customNavigationBar setTitle:temp.playinfo.title];
    [self.playView setPlayInfo:temp.playinfo];
    [self webViewChangeUrl:temp.playinfo.webview_url];
    [self.authorView setRadioAuthorInfo:temp.playinfo.userInfo];
    [self.authorView setAuthorInfo:temp.playinfo.authorInfo];
}

//背景scrollView
- (void)createAScrollView{
    self.backGroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - 64 - 90)];
    [self.backGroundScrollView setDelegate:self];
    [self.backGroundScrollView setBackgroundColor:[UIColor whiteColor]];
    [self.backGroundScrollView setScrollEnabled:NO];
    [self.backGroundScrollView setContentSize:CGSizeMake(kWidth * 3, 0)];
    [self.backGroundScrollView setContentOffset:CGPointMake(kWidth, 0)];
    [self.backGroundScrollView setScrollsToTop:NO];
    [self.backGroundScrollView setShowsHorizontalScrollIndicator:NO];
    [self.backGroundScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_backGroundScrollView];
//    [_backGroundScrollView release];
}

- (void)createSwipeGesture{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToLeft)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.backGroundScrollView addGestureRecognizer:swipeRight];
//    [swipeRight release];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeToRight)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.backGroundScrollView addGestureRecognizer:swipeLeft];
//    [swipeLeft release];
}

- (void)swipeToLeft{
    if (_backGroundScrollView.contentOffset.x < 2 * kWidth) {
        [_backGroundScrollView setContentOffset:CGPointMake(_backGroundScrollView.contentOffset.x + kWidth, 0) animated:YES];
        //控制台中的PageNumberView改变
        NSInteger pageNumber = _backGroundScrollView.contentOffset.x / kWidth + 1;
        [self.consoleView.pageNumberView setHighLightNumber:pageNumber];
    }
}

- (void)swipeToRight{
    if (_backGroundScrollView.contentOffset.x >= kWidth) {
        [_backGroundScrollView setContentOffset:CGPointMake(_backGroundScrollView.contentOffset.x - kWidth, 0) animated:YES];
        NSInteger pageNumber = _backGroundScrollView.contentOffset.x / kWidth - 1;
        [self.consoleView.pageNumberView setHighLightNumber:pageNumber];
    }
}
//创建一个tableView
- (void)createATableView{
    self.radioTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, _backGroundScrollView.height) style:UITableViewStylePlain];
    [self.radioTableView setScrollsToTop:NO];
    [self.radioTableView setBackgroundColor:[UIColor whiteColor]];
    self.radioTableView.showsHorizontalScrollIndicator = NO;
    self.radioTableView.showsVerticalScrollIndicator = NO;
    [self.radioTableView setDelegate:self];
    [self.radioTableView setDataSource:self];
    [self.radioTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.backGroundScrollView addSubview:_radioTableView];
//    [_radioTableView release];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _radioList ? _radioList.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kHeight / 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PlayRadioCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"PlayRadioCellXib" owner:self options:nil] firstObject];
    if (_radioList.count) {
        RedioDetailListModel *temp = [self.radioList objectAtIndex:indexPath.row];
        NSString *tingId = [temp.playinfo.tingid copy];
        if ([tingId isEqualToString:_detailPlayInfo.tingid]) {
            [self.radioTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
//        [tingId release];
        [cell setCellContent:temp];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //换歌之后 webView改变,作者栏改变 ,歌曲改变
    RedioDetailListModel *temp = [_radioList objectAtIndex:indexPath.row];
    [[StreamKitHandle shareStreamKitHandle] beginPlayWithUrlString:temp.playinfo.musicUrl];
    [self.playView setPlayInfo:temp.playinfo];
    [self.customNavigationBar setTitle:temp.title];
    UIButton *btn = [self.customNavigationBar viewWithTag:13001];
    BOOL isCollected = [self searchFromCoreDataWithEntityName:RadioModelType andIndentifier:temp.tingid];
    if (isCollected) {
        [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
    } else{
        [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
    }

    [self webViewChangeUrl:temp.playinfo.webview_url];
    [self.authorView setRadioAuthorInfo:temp.playinfo.userInfo];
    [self.authorView setAuthorInfo:temp.playinfo.authorInfo];
    [self.backGroundScrollView setContentOffset:CGPointMake(kWidth, 0) animated:YES];
}
//创建播放页面
- (void)createAPlayView{
    self.playView = [[PlayView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, _backGroundScrollView.height)];
    [self.playView setDelegate:self];
    [_playView setPlayInfo:_detailPlayInfo];
    [self.backGroundScrollView addSubview:_playView];
//    [_playView release];
}
//slider改变值时候改变播放器进度
- (void)sliderChangeTheValue:(CGFloat)value{
    [[StreamKitHandle shareStreamKitHandle].player seekToTime:value * [StreamKitHandle shareStreamKitHandle].player.duration];
}
//创建作者栏
- (void)createAAuthorView{
    self.authorView = [[[NSBundle mainBundle] loadNibNamed:@"PlayAuthorView" owner:self options:nil] firstObject];
    [self.authorView setFrame:CGRectMake(0, 0, kWidth, 40)];
    [self.authorView setRadioAuthorInfo:_detailPlayInfo.userInfo];
    [self.authorView setAuthorInfo:_detailPlayInfo.authorInfo];
    [self.authorView.authorButton addTarget:self action:@selector(athorViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.radioWebView addSubview:_authorView];
    [self.authorView.radioAuthorButton addTarget:self action:@selector(athorViewButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, _authorView.bottom, kWidth, 3)];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    [self.radioWebView addSubview:_webViewProgressView];
//    [_webViewProgressView release];
}

- (void)athorViewButtonAction:(UIButton *)button{
    UserViewController *userViewController = [UserViewController new];
    UserInfo *user = nil;
    if (button.tag == 20000) {
        user = _authorView.radioAuthorInfo;
    } else{
        user = _authorView.authorInfo;
    }
    [userViewController setUid:user.uid];
    [userViewController setUname:user.uname];
    [self.navigationController pushViewController:userViewController animated:YES];
//    [userViewController release];
}

//webView进度条改变代理方法
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_webViewProgressView setProgress:progress animated:YES];
}
//创建一个webView
- (void)createAWebView{
    self.radioWebView = [[UIWebView alloc]initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, _backGroundScrollView.height)];
    
    self.webViewProgress = [[NJKWebViewProgress alloc] init];
    [_webViewProgress setWebViewProxyDelegate:self];
    [_webViewProgress setProgressDelegate:self];
    [self.radioWebView setDelegate:_webViewProgress];
    [self.radioWebView setBackgroundColor:[UIColor whiteColor]];
    [self.backGroundScrollView addSubview:_radioWebView];
//    [_radioWebView release];
    [self webViewChangeUrl:_detailPlayInfo.webview_url];

}
//webViewJS交互
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth= %f;"
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height;"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);", kWidth]];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}
//改变WebView的方法
- (void)webViewChangeUrl:(NSString *)urlString{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.radioWebView loadRequest:request];
}
 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
