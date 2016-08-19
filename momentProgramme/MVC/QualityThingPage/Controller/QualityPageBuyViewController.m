//
//  QualityPageBuyViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "QualityPageBuyViewController.h"
#import <NJKWebViewProgressView.h>
#import <NJKWebViewProgress.h>
@interface QualityPageBuyViewController ()<UIWebViewDelegate , NJKWebViewProgressDelegate>
@property(nonatomic, retain) NJKWebViewProgress *webViewProgress;
@property(nonatomic, retain) NJKWebViewProgressView *webViewProgressView;


@end

@implementation QualityPageBuyViewController
- (void)dealloc{
//    [_webViewProgressView release];
//    [_webViewProgress release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:@"良品"];
    
    
    self.webViewProgressView = [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom - 3, kWidth, 3)];
    _webViewProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_webViewProgressView setProgress:0 animated:YES];
    [self.view addSubview:_webViewProgressView];
//    [_webViewProgressView release];
    [self webView];
   
}

- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress{
    [_webViewProgressView setProgress:progress animated:YES];
}

- (void)webView

{
    
    NSString *str = self.buyUrl;
    UIWebView *awebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth , kHeight - self.customNavigationBar.height)];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:str]];
    [awebView loadRequest:request];
    [self.view addSubview:awebView];
    
    
    
    awebView.delegate = self;
    
    self.webViewProgress = [[NJKWebViewProgress alloc] init];
    [self.webViewProgress setWebViewProxyDelegate:self];
    [self.webViewProgress setProgressDelegate:self];
    [awebView setDelegate:_webViewProgress];

    
    
    // 自动适应屏幕
    awebView.scalesPageToFit = YES;
    // 边界不回弹
    awebView.scrollView.bounces = NO;
    // 隐藏滑动线
    awebView.scrollView.showsVerticalScrollIndicator = NO;
//    [awebView release];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
