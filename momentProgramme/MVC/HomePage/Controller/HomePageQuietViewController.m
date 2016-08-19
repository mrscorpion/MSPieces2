//
//  HomePageQuietViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/22.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HomePageQuietViewController.h"
#import "StreamKitHandle.h"

#define kHieghts [UIScreen mainScreen].bounds.size.height / 667

@interface HomePageQuietViewController ()

@property(nonatomic, retain) NSDictionary *dataDic;

@property(nonatomic, retain) UIImageView *image;

@property(nonatomic, retain) UILabel *timeLabel;

@property(nonatomic, retain) UILabel *musicTitle;

@property(nonatomic, retain) UILabel *name;

@property(nonatomic, retain) UILabel *content;

@property(nonatomic, retain) UIButton *backButton;

@property(nonatomic, retain) UIView *lineView;

@property(nonatomic, retain) UIView *background;

@property(nonatomic, retain) UILabel *todayCount;

@property(nonatomic, copy) NSString *labelText;

@property(nonatomic, retain) UILabel *secondLabel;

@property (assign, nonatomic) BOOL first;

@end

@implementation HomePageQuietViewController
- (void)dealloc{
//    [_dataDic release];
//    [_image release];
//    [_timeLabel release];
//    [_musicTitle release];
//    [_name release];
//    [_content release];
//    [_backButton release];
//    [_lineView release];
//    [_background release];
//    [_todayCount release];
//    [_labelText release];
//    [_secondLabel release];

//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.first = NO;
    // Do any additional setup after loading the view.
    
    [self getDataFromInternet];

    
    
}


- (void)getDataFromInternet{
    NSString *str = @"http://mapi.pianke.me/pub/jing";
    NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @" 1 " , @"did" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" , @"version" : @" 3.0.6 "};
    [SVProgressHUD showInfoWithStatus:@"正在加载静静数据"];
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        self.dataDic  = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:self.dataDic];
        //开始播放静静
        [[StreamKitHandle shareStreamKitHandle] beginPlayJingJing:[self.dataDic objectForKey:@"audio"]];
        [SVProgressHUD dismiss];
        //更新剩余时间
        __block typeof(self) weakSelf = self;
        [[StreamKitHandle shareStreamKitHandle] progressBlock:^(NSString *currentTime, NSString *allTime, CGFloat progress) {
            NSString *lastTime = [currentTime substringFromIndex:3];
            NSInteger lastDate = 60 - [lastTime floatValue];
            self.labelText = [NSString stringWithFormat:@"%ld",lastDate];
            NSLog(@"当前播放剩余时间%@",self.labelText);
            [weakSelf.timeLabel setText:self.labelText];
            
            if ([self.labelText isEqualToString:@"56"]) {
                [UIView animateWithDuration:0.5 animations:^{
                self.background.alpha = 1;
                self.todayCount.alpha = 1;
                }];
            }else if([self.labelText isEqualToString:@"53"]){
                self.first = YES;
                [UIView animateWithDuration:0.5 animations:^{
                    self.background.alpha = 0;
                    self.todayCount.alpha = 0;

                }];
                
            }

            
        }];
        [[StreamKitHandle shareStreamKitHandle] finishBlock:^(STKAudioPlayerStopReason stopReason) {
            if (self.first) {
                [[StreamKitHandle shareStreamKitHandle] endPlayJingJing];
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }
        }];

    } failureBlock:^(NSError *error) {
        
    }];
    
    
}





- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.view addSubview:view];
//    [view release];
   
    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [self.image setUserInteractionEnabled:YES];
    [self.image sd_setImageWithURL:[NSURL URLWithString:[dictionary objectForKey:@"img"]] placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    [view addSubview:self.image];
//    [self.image release];
    
    
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kHeight - kHeight / 2.5, (kWidth - 40) / 3, (kWidth - 40) / 3 / 2)];
    
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.text = @"60";
    self.timeLabel.font = [UIFont systemFontOfSize:60 * kHieghts weight:0.5];
    [self.image addSubview:_timeLabel];
//    [_timeLabel release];
    
    
    self.secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.width - 30, self.timeLabel.height - 30, 30, 30)];
    self.secondLabel.text = @"S";
    self.secondLabel.textAlignment = NSTextAlignmentCenter;
    self.secondLabel.font = [UIFont systemFontOfSize:20 * kHieghts weight:0.5];
    self.secondLabel.textColor = [UIColor whiteColor];
    [self.timeLabel addSubview:self.secondLabel];
//    [self.secondLabel release];
    
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.timeLabel.x + self.timeLabel.width + 10, self.timeLabel.y, 10, self.timeLabel.height)];
    self.lineView.backgroundColor = [UIColor colorWithRed:0.976 green:0.955 blue:0.928 alpha:0.500];
    [self.image addSubview:_lineView];
//    [_lineView release];
    
    
    self.musicTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.lineView.x + self.lineView.width + 10, self.lineView.y, kWidth - 40 - self.timeLabel.width - 20 - self.lineView.width, 30)];
    self.musicTitle.font = [UIFont systemFontOfSize:17 * kHieghts weight:0.5];
    self.musicTitle.text = [dictionary objectForKey:@"title"];
    self.musicTitle.textColor = [UIColor whiteColor];
    [self.image addSubview:_musicTitle];
//    [_musicTitle release];
    
    self.name = [[UILabel alloc] initWithFrame:CGRectMake(self.musicTitle.x, self.musicTitle.y + self.musicTitle.height, self.musicTitle.width, 20)];
    self.name.font = [UIFont systemFontOfSize:15 * kHieghts];
    self.name.textColor = [UIColor whiteColor];
    self.name.text = [dictionary objectForKey:@"author"];
    [self.image addSubview:_name];
//    [_name release];
    
    
    
    CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:[self.dataDic objectForKey:@"text"] andFont:[UIFont systemFontOfSize:16] andLabelWidth:kWidth - 40];
    self.content = [[UILabel alloc] initWithFrame:CGRectMake(20, self.timeLabel.height + self.timeLabel.y + 20, kWidth - 40, contentHeight)];
    self.content.numberOfLines = 0;
    [self.content setFont:[UIFont systemFontOfSize:16 * kHieghts weight:0.5]];
    self.content.textColor = [UIColor whiteColor];
    self.content.lineBreakMode = NSLineBreakByCharWrapping;
    self.content.text = [dictionary objectForKey:@"text"];
    [self.image addSubview:_content];
//    [_content release];
    
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(kWidth - 70, kHeight - 70, 50, 50);
    [self.backButton setBackgroundImage:[UIImage imageNamed:@"Home_Back"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.image addSubview:_backButton];
    

    self.background = [[UIView alloc] initWithFrame:CGRectMake(30, kHeight / 2, kWidth - 60, 40)];
    [self.background setAlpha:0];
    self.background.layer.cornerRadius = 40 / 4;
    self.background.backgroundColor = [UIColor colorWithWhite:0.038 alpha:0.5];
    [self.image addSubview:_background];
//    [_background release];
    
    
    self.todayCount = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, self.background.width - 30, 20)];

    self.todayCount.textAlignment = NSTextAlignmentCenter;
    self.todayCount.text = [NSString stringWithFormat:@"你是今天第 %@ 位静静用户",[dictionary objectForKey:@"today_count"]];
    self.todayCount.textColor = [UIColor colorWithRed:0.986 green:1.000 blue:0.916 alpha:1];
    [self.todayCount setAlpha:0];
    [self.background addSubview:_todayCount];
//    [_todayCount release];
    

    
    
    
    
    
}


- (void)buttonAction:(UIButton *)btn{
    [[StreamKitHandle shareStreamKitHandle] endPlayJingJing];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

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
