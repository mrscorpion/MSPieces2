//
//  AboutUsViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AutoSize.h"
@interface AboutUsViewController ()

@property(nonatomic, retain)UIImageView *image;
@property(nonatomic, retain) UILabel *contentLabel;
@end

@implementation AboutUsViewController
- (void)dealloc{
//    [_image release];
//    [_contentLabel release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:@"EosWing"];
    [self createAView];
}
- (void)selectedLeftButton:(UIButton *)leftButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)createAView{

    self.image = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kWidth / 2)];
    self.image.image = [UIImage imageNamed:@"PIECES"];
    [self.view addSubview:self.image];
//    [self.image release];
    
    

    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.text = @"      Pieces(碎片)是一款阅读故事和聆听电台的App，由mr.scorpion和liujinglongxa共同制作。\n      Pieces在此声明,您通过本软件参与的任何商业活动,与Apple Inc.无关\n      本软件资源取自互联网,如有侵权请联络反馈问题邮箱,我们将立即进行删除,感谢您的理解.";
    CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:self.contentLabel.text andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
    [self.contentLabel setFrame:CGRectMake(20, self.image.height + self.image.y + 20, kWidth - 40, contentHeight)];
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.contentLabel];
//    [self.contentLabel release];
    
    
    
    
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
