//
//  DrawerViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "DrawerViewController.h"
#import "HomePageViewController.h"
#import "RedioPageViewController.h"
#import "ReadingPageViewController.h"
#import "PiecesPageViewController.h"
#import "QualityPageViewController.h"
#import "SearchViewController.h"
#import "UIView+FHYAdditions.h"
#import <UIViewController+MMDrawerController.h>
#import "DrawerViewCell.h"
#import "DrawerButtonView.h"
#import "DrawerRadioView.h"
#import "DrawerSearchView.h"
#import "AboutUsViewController.h"
#import "CollectionViewController.h"
#import "HomePageQuietViewController.h"
@interface DrawerViewController ()<UITableViewDataSource,UITableViewDelegate,DrawerButtonViewDelegat>
@property (retain, nonatomic) UITableView *tableView;
@property (retain, nonatomic) NSArray *viewControllerNames;
@property (retain, nonatomic) NSArray *iconArray;
@property (retain, nonatomic) NSArray *iconSeletedArray;
@property (retain, nonatomic) UIImageView *iconView;
@property (retain, nonatomic) DrawerButtonView *buttonView;
@property (retain, nonatomic) DrawerSearchView *searchView;
@property (retain, nonatomic) DrawerRadioView *musicView;
@property (retain, nonatomic) UIAlertController *picAlert;
@property (copy, nonatomic) NSString *cleanMemoryString;
@end

@implementation DrawerViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [SVProgressHUD dismiss];
}
- (void)dealloc
{
//    [_cleanMemoryString release];
//    [_picAlert release];
//    [_iconSeletedArray release];
//    [_searchView release];
//    [_musicView release];
//    [_iconView release];
//    [_iconArray release];
//    [_viewControllerNames release];
//    [_tableView release];
//    [super dealloc];
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.viewControllers = [NSMutableArray array];
        HomePageViewController *homeViewController = [HomePageViewController new];
        [self addAViewController:homeViewController];
        
        RedioPageViewController *redioPageViewController = [RedioPageViewController new];
        [self addAViewController:redioPageViewController];
        
        ReadingPageViewController *readingPageViewController = [ReadingPageViewController new];
        [self addAViewController:readingPageViewController];
        
        PiecesPageViewController *piecesPageViewController = [PiecesPageViewController new];
        [self addAViewController:piecesPageViewController];
        
        QualityPageViewController *qualityPageViewController = [QualityPageViewController new];
        [self addAViewController:qualityPageViewController];
        self.iconArray = @[[UIImage imageNamed:@"DrawerIcon_1_Selected"], [UIImage imageNamed:@"DrawerIcon_radio_Selected"], [UIImage imageNamed:@"DrawerIcon_reading_Selected"], [UIImage imageNamed:@"DrawerIcon_pieces_Selected"], [UIImage imageNamed:@"DrawerIcon_quality_Selected"]];
        
        self.viewControllerNames = @[@"首页", @"电台", @"阅读", @"碎片", @"良品"];
    }
    return self;
}

//为所有视图添加导航视图控制器 并加入到容器视图控制器数组中
- (void)addAViewController:(UIViewController *)viewController{
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
//    [viewController release];
    [navigationController.navigationBar setHidden:YES];
    [self.viewControllers addObject:navigationController];
//    [navigationController release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
    [self createIconView];
    [self createFourButton];
    [self createSearchBar];
    [self createATableView];
    [self createMusicView];
    
}
//创建图标View
- (void)createIconView{
//    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 25, kWidth - 20, (kWidth - 20) / 4)];
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 40, kWidth - 40, (kWidth - 20) / 8)];
    [self.iconView setImage:[UIImage imageNamed:@"PIECES"]];
    [self.iconView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_iconView];
//    [_iconView release];
}
//创建四个按钮
- (void)createFourButton{
    self.buttonView = [[DrawerButtonView alloc] initWithFrame:CGRectMake(0, _iconView.bottom, kWidth, 220 / 17 * 3)];
    [self.buttonView setDelegate:self];
    [self.buttonView setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
    [self.view addSubview:_buttonView];
//    [_buttonView release];

    [self.buttonView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    [self createPicAlertController];
}

- (void)createPicAlertController{
    self.picAlert = [UIAlertController alertControllerWithTitle:@"您是否要清除缓存的所有图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[SDImageCache sharedImageCache] clearDisk];
        [[SDImageCache sharedImageCache] clearMemory];
        UIAlertView *cleanOkAlert = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"您清除了%@缓存",_cleanMemoryString] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [cleanOkAlert show];
    }];
    [self.picAlert addAction:cancelAction];
    [self.picAlert addAction:okAction];
}
- (void)selectedButton:(UIButton *)button{
    switch (button.tag) {
        case 10000:
        {
            NSLog(@"关于我们");
            AboutUsViewController *aboutUs = [[AboutUsViewController alloc] init];
            [self presentViewController:aboutUs animated:YES completion:^{
                
            }];
//            [aboutUs release];
        }
            break;
        case 10001:
        {
            NSLog(@"喜欢");
            CollectionViewController *collectionViewController = [CollectionViewController new];
            UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:collectionViewController];
//            [collectionViewController release];
            [navigationController.navigationBar setHidden:YES];
            [self presentViewController:navigationController animated:YES completion:^{
                
            }];
//            [navigationController release];
        }
            break;
        case 10002:
        {
            NSLog(@"清除缓存");
            self.cleanMemoryString = [NSString stringWithFormat:@"%ldM",[[SDImageCache sharedImageCache] getSize] / 1024 / 1024];
            [self cleanPic];
        }
            break;
        default:
        {
            NSLog(@"静静");
            HomePageQuietViewController *quiet = [[HomePageQuietViewController alloc] init];
            [self presentViewController:quiet animated:YES completion:^{
                
                
            }];
        }
            break;
    }
}

- (void)cleanPic{
    [self presentViewController:self.picAlert animated:YES completion:^{
        
    }];
}

//创建搜索框
- (void)createSearchBar{
    self.searchView = [[DrawerSearchView alloc] initWithFrame:CGRectMake(0, _buttonView.bottom, kWidth, 50)];
    [self.searchView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.searchView.searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.searchView setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
    [self.view addSubview:_searchView];
//    [_searchView release];
}

- (void)searchButtonAction:(UIButton *)button{
    SearchViewController *searchViewController = [SearchViewController new];
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:searchViewController];
//    [searchViewController release];
    [navigationController.navigationBar setHidden:YES];
    [self presentViewController:navigationController animated:YES completion:nil];
}

//创建TableView
- (void) createATableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchView.bottom, kWidth, kHeight - _searchView.bottom - 70) style:UITableViewStylePlain];
    [self.tableView setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[DrawerViewCell class] forCellReuseIdentifier:@"DrawerViewCell"];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_tableView];
//    [_tableView release];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220 / 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DrawerViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DrawerViewCell" forIndexPath:indexPath];
        [cell setImage:_iconArray[indexPath.row] andLabelText:_viewControllerNames[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSInteger i = 0; i < _iconArray.count; i++) {
       DrawerViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
       [cell.contentView setBackgroundColor:[UIColor colorWithWhite:0.149 alpha:1.000]];
    }
    DrawerViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor colorWithWhite:0.278 alpha:1.000]];
    UIViewController *turnToViewController = _viewControllers[indexPath.row];
    [self.mm_drawerController setCenterViewController:turnToViewController withCloseAnimation:YES completion:nil];
}


//创建音乐模块
- (void)createMusicView{
    self.musicView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerRadioView" owner:self options:nil] firstObject];
    [self.musicView setFrame:CGRectMake(0, self.tableView.bottom, kWidth, 70)];
    [self.musicView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:_musicView];
//    [_musicView release];
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
