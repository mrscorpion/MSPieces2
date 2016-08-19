//
//  UserViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "UserViewController.h"
#import "PlayRadioViewController.h"
#import "RedioDetailListModel.h"
#import "UserPageDetailModel.h"
#import "UserPageInfoModel.h"
#import "PlayInfo.h"

#import "UserPageCellOne.h"
#import "UserPageRadioCell.h"
#import "UserPageTopicCell.h"
#import "HomePageDetailsViewController.h"
#import "UserHeaderView.h"


@interface UserViewController ()<UserHeaderViewDelegate>

@property (nonatomic, assign) NSInteger userPageNumber;
@property (nonatomic, retain) NSMutableArray *contentArray;
@property (nonatomic, retain) UserPageInfoModel *userInfo;
@property (nonatomic, retain) UserHeaderView *headerView;

@end

@implementation UserViewController
- (void)dealloc
{
    [SVProgressHUD dismiss];
//    [_headerView release];
//    [_userInfo release];
//    [_contentArray release];
//    [_uid release];
//    [_uname release];
//    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.969 alpha:1.000]];
    self.userPageNumber = 0;
    self.contentArray = [NSMutableArray array];
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:_uname];
    [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshPush];
}

- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - 64)];
    [self.fhyTableView registerClass:[UserPageCellOne class] forCellReuseIdentifier:@"UserPageCellOne"];
    [self.fhyTableView registerNib:[UINib nibWithNibName:@"UserPageRadioCell" bundle:nil] forCellReuseIdentifier:@"UserPageRadioCell"];
    [self.fhyTableView registerNib:[UINib nibWithNibName:@"UserPageTopicCellXib" bundle:nil] forCellReuseIdentifier:@"UserPageTopicCell"];
    self.headerView = [[[NSBundle mainBundle] loadNibNamed:@"UserHeaderViewXib" owner:nil options:nil] firstObject];
    BOOL isFollowed = [self searchFromCoreDataWithEntityName:UserModelType andIndentifier:_uid];
    if (isFollowed) {
        [self.headerView.followButton setTitle:@"已关注" forState:UIControlStateNormal];
    } else{
        [self.headerView.followButton setTitle:@"＋关注" forState:UIControlStateNormal];
    }
    [self.headerView setDelegate:self];
    [self.headerView setFrame:CGRectMake(0, 0, kWidth, 160)];
}

- (void)selectedButton:(UIButton *)button{
    if ([[button titleForState:UIControlStateNormal] isEqualToString:@"已关注"]) {
//        [self insertEntityToCoreDataWithEntityName:UserModelType andObject:[self.userInfo retain]];
        [self insertEntityToCoreDataWithEntityName:UserModelType andObject:self.userInfo];
    } else {
//        [self deleteEntityObjectWithObject:[self.userInfo retain] andEntityName:UserModelType];
        [self deleteEntityObjectWithObject:self.userInfo andEntityName:UserModelType];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset < 0)
    {
        CGFloat factor = ABS(yOffset) + 160;
        CGRect frame = CGRectMake(-([[UIScreen mainScreen] bounds].size.width * factor/160 - [[UIScreen mainScreen] bounds].size.width) / 2,
                                  -ABS(yOffset),
                                  [[UIScreen mainScreen] bounds].size.width * factor/160,
                                  factor);
        self.headerView.backImageView.frame = frame;
        
    } else {
        CGRect frame = self.headerView.frame;
        frame.origin.y = 0;
        self.headerView.frame = frame;
        self.headerView.backImageView.frame = CGRectMake(0, frame.origin.y, [[UIScreen mainScreen] bounds].size.width, 160);
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _contentArray.count ? _contentArray.count : 0 ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserPageDetailModel *temp = [_contentArray objectAtIndex:indexPath.row];
    if (temp.playinfo.imgUrl) {
        UserPageRadioCell *radioCell = [tableView dequeueReusableCellWithIdentifier:@"UserPageRadioCell" forIndexPath:indexPath];
        [radioCell setDetailModel:temp];
        return radioCell;
    } else if ([temp.type isEqualToNumber:@(9)] || [temp.type isEqualToNumber:@(15)] ){
        UserPageTopicCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"UserPageTopicCell" forIndexPath:indexPath];
        [topicCell setDetailModel:temp];
        return topicCell;
    } else{
        UserPageCellOne *cellOne = [tableView dequeueReusableCellWithIdentifier:@"UserPageCellOne" forIndexPath:indexPath];
        [cellOne.pic setUserInteractionEnabled:YES];
        [cellOne.pic addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
        [cellOne setDetailModel:temp];
        return cellOne;
    }
}

- (void)actionTap:(UITapGestureRecognizer *)sender{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setTag:99999];
    [self.view addSubview:bgView];
//    [bgView release];
    CGPoint location = [sender locationInView:self.fhyTableView];
    NSIndexPath *indexPath = [self.fhyTableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *)[self.fhyTableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:77777];
    cell.contentView.frame = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.fhyTableView.contentOffset.y + 60, imageView.frame.size.width, imageView.frame.size.height);
    
    UIImageView *fullImageView = [[UIImageView alloc] init];
    fullImageView.backgroundColor = [UIColor blackColor];
    fullImageView.userInteractionEnabled = YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapTwo:)]];
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (![fullImageView superview]) {
        fullImageView.image = imageView.image;
        fullImageView.frame = cell.contentView.frame;
        [bgView addSubview:fullImageView];
        [UIView animateWithDuration:0.5 animations:^{
            fullImageView.frame=CGRectMake(0, 0, kWidth, kHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden=YES;
        }];
    }
}


- (void)actionTapTwo:(UITapGestureRecognizer *)sender{
    [[self.view viewWithTag:99999] removeFromSuperview];
    [UIApplication sharedApplication].statusBarHidden=NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserPageDetailModel *temp = [_contentArray objectAtIndex:indexPath.row];
    if ([temp.type isEqualToNumber:@(17)]) {
        return 150;
    } else if ([temp.type isEqualToNumber:@(9)] || [temp.type isEqualToNumber:@(15)] ){
        return 170;
    } else{
        CGFloat height = [AutoSize AutoSizeOfHeightWithText:temp.content andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
        CGFloat imageHeight = 0;
        if (temp.coverimg.length > 0) {
            NSArray *widthAndHeight = [temp.coverimg_wh componentsSeparatedByString:@"*"];
            CGFloat width = [[widthAndHeight objectAtIndex:0] floatValue];
            CGFloat height = [[widthAndHeight objectAtIndex:1] floatValue];
            CGFloat mul = height / width;
            imageHeight = (kWidth - 40) * mul;
        }
        return height + imageHeight + 80;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserPageDetailModel *temp = [_contentArray objectAtIndex:indexPath.row];
    if ([temp.type isEqualToNumber:@(17)]) {
        //temp 是你自己的Model  其中要有一个属性是PlayInfo
        //因为要传入数组到处理类中以供所以创建一个RedioDetailListModel的对象
        RedioDetailListModel *tempArrayObject = [RedioDetailListModel new];
        //把playInfo传到这个对象里
        //把playInfo的musicUrl传到这个对象里
        //把playInfo的title传到这个对象里
        tempArrayObject.playinfo = temp.playinfo;
        tempArrayObject.musicUrl = temp.playinfo.musicUrl;
        tempArrayObject.title = temp.playinfo.title;
        //构建一个播放radio的详情页Vc
        PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
        [self.navigationController pushViewController:playViewController animated:YES];
//        [playViewController release];
        //为这个Vc设置当前播放的playInfo
        [playViewController setDetailPlayInfo:temp.playinfo];
        //为这个VC设置播放列表的model数组  此处因为数据原因仅传入一个进去
        [playViewController setRadioListArrayToPlayer:[NSMutableArray arrayWithObject:tempArrayObject]];

        
    } else if ([temp.type isEqualToNumber:@(15)] ||
               [temp.type isEqualToNumber:@(9)]){
        HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
        web.contentId = temp.contentid;
        web.content = temp.content;
        web.typeTitle = temp.title;
        [self.navigationController pushViewController:web animated:YES];
//        [web release];
    }
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.footer isRefreshing];
    NSDictionary *parameters = @{@"auth" : @"", @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" , @"uid" : _uid, @"start" : [NSString stringWithFormat:@"%ld", self.userPageNumber], @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:[NSString stringWithFormat:@"http://api2.pianke.me/profile/%@",self.pullOrPush ? @"info" : @"feed"] parameters:parameters showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:data];
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        NSLog(@"%@",error);
    }];
}

//type 17 电台 type 15 9 文章 type 2 碎片 // type24 不要话题
- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (_userPageNumber == 0) {
        NSDictionary *userDic = [dictionary objectForKey:@"userinfo"];
        self.userInfo = [[UserPageInfoModel alloc] initWithDictionary:userDic];
        [self.headerView setHeaderViewInfo:_userInfo];
        [self.fhyTableView setTableHeaderView:_headerView];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    for (NSDictionary *listModelDic in listArray) {
        UserPageDetailModel *detailModel = [[UserPageDetailModel alloc] initWithDictionary:listModelDic];
        if ([detailModel.type isEqualToNumber:@(17)] ||
            [detailModel.type isEqualToNumber:@(15)] ||
            [detailModel.type isEqualToNumber:@(9)] ||
             [detailModel.type isEqualToNumber:@(2)]) {
            [self.contentArray addObject:detailModel];
        }
//        [detailModel release];
    }
    [self endRefresh];
}


- (void)push{
    [super push];
    self.userPageNumber = self.userPageNumber + 10;
    [self getDataFromInternet];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
