//
//  HomePageDetailsViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/21.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HomePageDetailsViewController.h"
#import <NJKWebViewProgress.h>
#import <NJKWebViewProgressView.h>
@interface HomePageDetailsViewController ()<UIWebViewDelegate , NJKWebViewProgressDelegate>
@property(nonatomic, retain) UIWebView *homeWebView;

@property(nonatomic, retain) NJKWebViewProgress *webViewProgress;

@property(nonatomic, retain) NJKWebViewProgressView *webViewProgressView;

@end

@implementation HomePageDetailsViewController
- (void)dealloc{
//    [_homeWebView release];
//    [_contentId release];
//    [_typeTitle release];
//    [_webViewProgress release];
//    [_webViewProgressView release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:8001 - i];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:btn];
        
        if (btn.tag == 8000) {
            BOOL isFollowed = [self searchFromCoreDataWithEntityName:TopicModelType andIndentifier:self.contentId];
            if (isFollowed) {
                [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
            } else{
                [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
            }
            
        }else if (btn.tag == 8001){
            [btn setBackgroundImage:[UIImage imageNamed:@"Play_2"] forState:UIControlStateNormal];
            
        }
        
    }
    
    
    
    
    
    [self createNavigationBar:LeftButtonBackType andRightButtons:buttons andTitleName:self.typeTitle];
    [self webView];
    
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


- (void)viewDidDisappear:(BOOL)animated{
    [self.homeWebView setDelegate:nil];
    [super viewDidDisappear:animated];
}



- (void)btn:(UIButton *)btn{
    if (btn.tag == 8000) {
        btn.selected = !btn.isSelected;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:self.content forKey:@"content"];
        [dic setValue:self.contentId forKey:@"contentid"];
        [dic setValue:self.typeTitle forKey:@"title"];
        if ([[btn backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"Play_1"]]) {
            [btn setBackgroundImage:[UIImage imageNamed:@"Play_1_Selected"] forState:UIControlStateNormal];
//            [self insertEntityToCoreDataWithEntityName:TopicModelType andObject:[dic retain]];
            [self insertEntityToCoreDataWithEntityName:TopicModelType andObject:dic];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"Play_1"] forState:UIControlStateNormal];
//            [self deleteEntityObjectWithObject:[dic retain] andEntityName:TopicModelType];
            [self deleteEntityObjectWithObject:dic andEntityName:TopicModelType];
        }
        
    }else if (btn.tag == 8001){
        [btn setImage:[UIImage imageNamed:@"Play_2"] forState:UIControlStateNormal];
        [self shareWithContent:[NSString stringWithFormat:@"我正在EosWing App阅读故事:%@", self.customNavigationBar.titleLabel.text] andButton:btn];
    }
}


- (void)webView
{
    NSString *str1 = @"http://api2.pianke.me/article/info";
    NSDictionary *dic1 = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg", @"client" : @"1", @"contentid" : [NSString stringWithFormat:@"%@",self.contentId], @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8", @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:str1 parameters:dic1 showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        if (self) {
            [self createWebView:responseObject];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

- (void)createWebView:(id)responseObject{
    self.homeWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height)];
    self.homeWebView.backgroundColor = [UIColor whiteColor];
    [self.homeWebView loadHTMLString:[[responseObject objectForKey:@"data"] objectForKey:@"html"] baseURL:nil];
    
    self.webViewProgress = [[NJKWebViewProgress alloc] init];
    [self.webViewProgress setWebViewProxyDelegate:self];
    [self.webViewProgress setProgressDelegate:self];
    [self.homeWebView setDelegate:self.webViewProgress];
    [self.view addSubview:_homeWebView];
//    [_homeWebView release];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [_webViewProgressView setProgress:1 animated:YES];
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
    "document.getElementsByTagName('head')[0].appendChild(script);",kWidth - 20]];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
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
