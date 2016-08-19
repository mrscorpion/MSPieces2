//
//  ReadingPageScrollViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/16.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageScrollViewController.h"
#import "ReadingPageDetailsViewController.h"
#import "ReadingPageHotViewController.h"
@interface ReadingPageScrollViewController ()<UIScrollViewDelegate>


@property(nonatomic, retain) ReadingPageDetailsViewController *readingPageDetaisl;
@property(nonatomic, retain) ReadingPageHotViewController *readingPageHot;
@property(nonatomic, retain) UIScrollView *scrollView;



@end

@implementation ReadingPageScrollViewController
- (void)dealloc{
//    [_readingPageDetaisl release];
//    [_readingPageHot release];
//    [_scrollView release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addSwipeGesture];
    NSMutableArray *buttons = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
       UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTag:1001 - i];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [buttons addObject:btn];
        if (btn.tag == 1001) {
            [btn setBackgroundImage:[UIImage imageNamed:@"Reading_Hot"] forState:UIControlStateNormal];
        }else{
            [btn setBackgroundImage:[UIImage imageNamed:@"Reading_New_Selected"] forState:UIControlStateNormal];
            
        }
    }
    
    
    [self createNavigationBar:LeftButtonBackType andRightButtons:buttons andTitleName:self.name];
    [self.customNavigationBar setShowUnderLine:YES];
    
    [self createScrollView];
    [self addChildViewControllers];

    
}



- (void)createScrollView{
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, self.view.frame.size.width, self.view.frame.size.height - self.customNavigationBar.frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
//    [self.scrollView release];
    
    
    
}

- (void)addChildViewControllers{
    self.readingPageDetaisl = [[ReadingPageDetailsViewController alloc] init];
    [self addChildViewController:_readingPageDetaisl];
//    [_readingPageDetaisl release];
    self.readingPageDetaisl.type = self.type;
    [self.readingPageDetaisl.view setFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:_readingPageDetaisl.view];
//    [_readingPageDetaisl.view release];
    
    
    self.readingPageHot = [[ReadingPageHotViewController alloc] init];
    [self addChildViewController:_readingPageHot];
//    [_readingPageHot release];
    self.readingPageHot.type = self.type;
    [self.readingPageHot.view setFrame:CGRectMake(kWidth, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    [self.scrollView addSubview:_readingPageHot.view];
//    [_readingPageHot.view release];
    
    
}


- (void)btn:(UIButton *)btn{
    [self.customNavigationBar scrollUnderLineToButton:btn];
    [self.scrollView setContentOffset:CGPointMake((btn.tag - 1000) * self.scrollView.frame.size.width , 0) animated:YES];
    if (btn.tag == 1001) {
        UIButton *buttonTwo = [self.customNavigationBar viewWithTag:1000];
        [btn setBackgroundImage:[UIImage imageNamed:@"Reading_Hot_Selected"] forState:UIControlStateNormal];
        [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Reading_New"] forState:UIControlStateNormal];
    }else{
        UIButton *buttonTwo = [self.customNavigationBar viewWithTag:1001];
        [btn setBackgroundImage:[UIImage imageNamed:@"Reading_New_Selected"] forState:UIControlStateNormal];
         [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Reading_Hot"] forState:UIControlStateNormal];
        }
        
        
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger tag = scrollView.contentOffset.x / self.view.frame.size.width + 1000;
    UIButton *button = [self.customNavigationBar viewWithTag:tag];
    [self.customNavigationBar scrollUnderLineToButton:button];
    
    
    if (tag == 1001) {
        UIButton *buttonTwo = [self.customNavigationBar viewWithTag:1000];
        [button setBackgroundImage:[UIImage imageNamed:@"Reading_Hot_Selected"] forState:UIControlStateNormal];
        [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Reading_New"] forState:UIControlStateNormal];
    }else{
        UIButton *buttonTwo = [self.customNavigationBar viewWithTag:1001];
            [button setBackgroundImage:[UIImage imageNamed:@"Reading_New_Selected"] forState:UIControlStateNormal];
            [buttonTwo setBackgroundImage:[UIImage imageNamed:@"Reading_Hot"] forState:UIControlStateNormal];
    }
    

    
    
    
    
    
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
