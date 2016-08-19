//
//  CollectionViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/25.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "CollectionViewController.h"

#import "SearchDetailViewSegmentView.h"
#import "SearchViewTableViewHeader.h"

#import "SearchUserCell.h"
#import "SearchTopicCell.h"
#import "SearchTingCell.h"

#import "UserInfo.h"
#import "PlayInfo.h"
#import "RedioDetailListModel.h"

#import "UserModel.h"
#import "RadioModel.h"
#import "TopicModel.h"

#import "SearchTopicModel.h"
#import "SearchTingModel.h"


#import "UserViewController.h"
#import "PlayRadioViewController.h"
#import "HomePageDetailsViewController.h"


@interface CollectionViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SearchDetailViewSegmentViewDelegate>
@property (retain, nonatomic) SearchDetailViewSegmentView *segmentView;
@property (retain, nonatomic) NSMutableArray *sectionArray;
@property (retain, nonatomic) NSArray *userDBArray;
@property (retain, nonatomic) NSArray *topicDBArray;
@property (retain, nonatomic) NSArray *radioDBArray;
@property (retain, nonatomic) UIScrollView *bigScrollView;
@property (retain, nonatomic) UITableView *allTableView;
@property (retain, nonatomic) UITableView *userTableView;
@property (assign, nonatomic) NSInteger userPageNumber;
@property (retain, nonatomic) NSMutableArray *userArray;
@property (retain, nonatomic) UITableView *radioTableView;
@property (assign, nonatomic) NSInteger radioPageNumber;
@property (retain, nonatomic) NSMutableArray *radioArray;
@property (retain, nonatomic) UITableView *topicTableView;
@property (assign, nonatomic) NSInteger topicPageNumber;
@property (retain, nonatomic) NSMutableArray *topicArray;

@end

@implementation CollectionViewController
- (void)dealloc
{
//    [_userArray release];
//    [_radioArray release];
//    [_topicArray release];
//    [_bigScrollView release];
//    [_allTableView release];
//    [_userTableView release];
//    [_radioTableView release];
//    [_topicTableView release];
//    [_segmentView release];
//    [_sectionArray release];
//    [super dealloc];
}

- (void)selectedLeftButton:(UIButton *)leftButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.sectionArray = [NSMutableArray array];
        self.userArray = [NSMutableArray array];
        self.userPageNumber = 0;
        self.radioArray = [NSMutableArray array];
        self.radioPageNumber = 0;
        self.topicArray = [NSMutableArray array];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self searchFromCoreData];
}



- (void)searchFromCoreData{
    [self.sectionArray removeAllObjects];
    [self.userArray removeAllObjects];
    [self.radioArray removeAllObjects];
    [self.topicArray removeAllObjects];
    self.userDBArray = [self searchFromCoreDataWithEntityName:UserModelType];
    self.topicDBArray = [self searchFromCoreDataWithEntityName:TopicModelType];
    self.radioDBArray = [self searchFromCoreDataWithEntityName:RadioModelType];
    [self changeDBModelToCustomModel];
    if (self.segmentView != nil) {
        NSMutableArray *total = [NSMutableArray array];
        NSInteger allTotalNumber = 0;
        NSString *totalStringUser = [NSString stringWithFormat:@"%@\n%ld", @"用户", self.userArray.count];
        NSString *totalStringTing = [NSString stringWithFormat:@"%@\n%ld", @"Ting", self.radioArray.count];
        NSString *totalStringTopic = [NSString stringWithFormat:@"%@\n%ld", @"故事", self.topicArray.count];
        allTotalNumber = self.userArray.count + self.topicArray.count + self.radioArray.count;
        [total addObject:totalStringUser];
        [total addObject:totalStringTing];
        [total addObject:totalStringTopic];
        NSString *allTotalString = [NSString stringWithFormat:@"全部\n%ld", allTotalNumber];
        [total insertObject:allTotalString atIndex:0];
        [self.segmentView setTitleContentArray:total];
    }
    [self.allTableView reloadData];
    [self.userTableView reloadData];
    [self.radioTableView reloadData];
    [self.topicTableView reloadData];
}

- (void)changeDBModelToCustomModel{
    for (UserModel *userModel in self.userDBArray) {
        UserInfo *userInfo = [UserInfo new];
        userInfo.icon = userModel.icon;
        userInfo.uname = userModel.uname;
        userInfo.uid = userModel.uid;
        [self.userArray addObject:userInfo];
//        [userInfo release];
    }
    for (RadioModel *radioModel in self.radioDBArray) {
        SearchTingModel *searchTingModel = [SearchTingModel new];
        searchTingModel.firstimage = radioModel.imgUrl;
        searchTingModel.title = radioModel.title;
        searchTingModel.userInfo = [UserInfo new];
        searchTingModel.userInfo.uid = radioModel.uidAuthor;
        searchTingModel.userInfo.uname = radioModel.unameAuthor;
        searchTingModel.userInfo.icon = radioModel.iconAuthor;
        
        
        searchTingModel.playinfo = [PlayInfo new];
        searchTingModel.playinfo.userInfo = [UserInfo new];
        searchTingModel.playinfo.authorInfo = [UserInfo new];
        searchTingModel.playinfo.userInfo.uid = radioModel.uidUser;
        searchTingModel.playinfo.userInfo.uname = radioModel.unameUser;
        searchTingModel.playinfo.userInfo.icon = radioModel.iconUser;
        searchTingModel.playinfo.authorInfo.uid = radioModel.uidAuthor;
        searchTingModel.playinfo.authorInfo.uname = radioModel.unameAuthor;
        searchTingModel.playinfo.authorInfo.icon = radioModel.iconAuthor;
        
        searchTingModel.playinfo.imgUrl = radioModel.imgUrl;
        searchTingModel.playinfo.musicUrl = radioModel.musicUrl;
        searchTingModel.playinfo.sharepic = radioModel.sharepic;
        searchTingModel.playinfo.sharetext = radioModel.sharetext;
        searchTingModel.playinfo.shareurl = radioModel.shareurl;
        searchTingModel.playinfo.ting_contentid = radioModel.ting_contentid;
        searchTingModel.playinfo.tingid = radioModel.tingid;
        searchTingModel.playinfo.title = radioModel.title;
        searchTingModel.playinfo.webview_url = radioModel.webview_url;
        [self.radioArray addObject:searchTingModel];
//        [searchTingModel release];
    }
    for (TopicModel *topicModel in self.topicDBArray) {
        SearchTopicModel *searchTopicModel = [SearchTopicModel new];
        searchTopicModel.contentid = topicModel.contentid;
        searchTopicModel.title = topicModel.title;
        searchTopicModel.shortcontent = topicModel.content;
        [self.topicArray addObject:searchTopicModel];
//        [searchTopicModel release];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:@"我的喜爱"];
    [self createSegmentView];
    [self createScrollView];
    [self createAllTableView];
}

- (void)createSegmentView{
    self.segmentView = [[SearchDetailViewSegmentView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, 44)];
    [self.segmentView setDelegate:self];
    NSMutableArray *total = [NSMutableArray array];
    NSInteger allTotalNumber = 0;
    NSString *totalStringUser = [NSString stringWithFormat:@"%@\n%ld", @"用户", self.userArray.count];
    NSString *totalStringTing = [NSString stringWithFormat:@"%@\n%ld", @"Ting", self.radioArray.count];
    NSString *totalStringTopic = [NSString stringWithFormat:@"%@\n%ld", @"故事", self.topicArray.count];
    allTotalNumber = self.userArray.count + self.topicArray.count + self.radioArray.count;
    [total addObject:totalStringUser];
    [total addObject:totalStringTing];
    [total addObject:totalStringTopic];
    NSString *allTotalString = [NSString stringWithFormat:@"全部\n%ld", allTotalNumber];
    [total insertObject:allTotalString atIndex:0];
    [self.segmentView setTitleContentArray:total];
    [self.view addSubview:_segmentView];
//    [_segmentView release];
}

- (void)selectButton:(NSInteger)number{
    CGFloat contentOffX = kWidth * number;
    if (contentOffX != _bigScrollView.contentOffset.x) {
        [_bigScrollView setContentOffset:CGPointMake(contentOffX, 0) animated:YES];
    }
    NSLog(@"点击了或滑动到了第~~~%ld个button",number);
    if (number == 1 && self.userTableView == nil) {
        [self createUserTableView];
    } else if (number == 2 && self.radioTableView == nil){
        [self createTingTableView];
    } else if (number == 3 && self.topicTableView == nil){
        [self createTopicTableView];
    }
}

- (void)createScrollView{
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom + 1, kWidth, kHeight - _segmentView.bottom - 1)];
    [self.bigScrollView setPagingEnabled:YES];
    [self.bigScrollView setDelegate:self];
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    self.bigScrollView.showsVerticalScrollIndicator = NO;
    [self.bigScrollView setContentSize:CGSizeMake(4 * kWidth, 0)];
    [self.view addSubview:_bigScrollView];
//    [_bigScrollView release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual: _bigScrollView]) {
        NSInteger buttonNumber = scrollView.contentOffset.x / kWidth;
        UIButton *button = [self.segmentView viewWithTag:25000 + buttonNumber];
        [self.segmentView segmentButtonAction:button];
    }
}

- (void)createAllTableView{
    self.allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.allTableView setDelegate:self];
    [self.allTableView setDataSource:self];
    [self.allTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.bigScrollView addSubview:_allTableView];
    self.allTableView.showsHorizontalScrollIndicator = NO;
    self.allTableView.showsVerticalScrollIndicator = NO;
    [self.allTableView registerNib:[UINib nibWithNibName:@"SearchUserCell" bundle:nil] forCellReuseIdentifier:@"SearchUserCell"];
    [self.allTableView registerNib:[UINib nibWithNibName:@"SearchTingCell" bundle:nil] forCellReuseIdentifier:@"SearchTingCell"];
    [self.allTableView registerNib:[UINib nibWithNibName:@"SearchTopicCell" bundle:nil] forCellReuseIdentifier:@"SearchTopicCell"];
    [self.allTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_allTableView release];
}


- (void)createUserTableView{
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.userTableView setDelegate:self];
    [self.userTableView setDataSource:self];
    [self.userTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.bigScrollView addSubview:_userTableView];
    self.userTableView.showsHorizontalScrollIndicator = NO;
    self.userTableView.showsVerticalScrollIndicator = NO;
    [self.userTableView registerNib:[UINib nibWithNibName:@"SearchUserCell" bundle:nil] forCellReuseIdentifier:@"SearchUserCell"];
    [self.userTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_userTableView release];
}


- (void)createTingTableView{
    self.radioTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 2,0, kWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.radioTableView setDelegate:self];
    [self.radioTableView setDataSource:self];
    [self.radioTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.bigScrollView addSubview:_radioTableView];
    self.radioTableView.showsHorizontalScrollIndicator = NO;
    self.radioTableView.showsVerticalScrollIndicator = NO;
    [self.radioTableView registerNib:[UINib nibWithNibName:@"SearchTingCell" bundle:nil] forCellReuseIdentifier:@"SearchTingCell"];
    [self.radioTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_radioTableView release];
}

- (void)createTopicTableView{
    self.topicTableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth * 3,0, kWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.topicTableView setDelegate:self];
    [self.topicTableView setDataSource:self];
    [self.topicTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.bigScrollView addSubview:_topicTableView];
    self.topicTableView.showsHorizontalScrollIndicator = NO;
    self.topicTableView.showsVerticalScrollIndicator = NO;
    [self.topicTableView registerNib:[UINib nibWithNibName:@"SearchTopicCell" bundle:nil] forCellReuseIdentifier:@"SearchTopicCell"];
    [self.topicTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_topicTableView release];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:_allTableView]) {
        return 3;
    } else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_allTableView]) {
        NSInteger numberOfRows = 0;
        switch (section) {
            case 0:
                numberOfRows = self.userArray.count;
                break;
            case 1:
                numberOfRows = self.radioArray.count;
                break;
            case 2:
                numberOfRows = self.topicArray.count;
                break;
        }
        return numberOfRows;
    } else if ([tableView isEqual:_userTableView]){
        return self.userArray.count ? _userArray.count : 0;
    } else if ([tableView isEqual:_radioTableView]){
        return self.radioArray.count ? _radioArray.count : 0;
    } else if ([tableView isEqual:_topicTableView]){
        return self.topicArray.count ? _topicArray.count : 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_allTableView]) {
        if (indexPath.section == 0) {
            SearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchUserCell" forIndexPath:indexPath];
            UserInfo *tempUser = [_userArray objectAtIndex:indexPath.row];
            [cell setCellContent:tempUser];
            return cell;
        } else if (indexPath.section == 2){
            SearchTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTopicCell" forIndexPath:indexPath];
            SearchTopicModel *tempTopic = [_topicArray objectAtIndex:indexPath.row];
            [cell setCellContent:tempTopic];
            return cell;
        } else {
            SearchTingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTingCell" forIndexPath:indexPath];
            SearchTingModel *tempTing = [_radioArray objectAtIndex:indexPath.row];
            [cell setCellContent:tempTing];
            return cell;
        }
    } else if ([tableView isEqual:_userTableView]){
        SearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchUserCell" forIndexPath:indexPath];
        UserInfo *tempUser = [self.userArray objectAtIndex:indexPath.row];
        [cell setCellContent:tempUser];
        return cell;
    } else if ([tableView isEqual:_radioTableView]){
        SearchTingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTingCell" forIndexPath:indexPath];
        SearchTingModel *tempTing = [self.radioArray objectAtIndex:indexPath.row];
        [cell setCellContent:tempTing];
        return cell;
    } else if ([tableView isEqual:_topicTableView]){
        SearchTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTopicCell" forIndexPath:indexPath];
        SearchTopicModel *tempTopic = [self.topicArray objectAtIndex:indexPath.row];
        [cell setCellContent:tempTopic];
        return cell;
    } else{
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_allTableView]) {
        if (indexPath.section == 0) {
            UserInfo *tempUser = [_userArray objectAtIndex:indexPath.row];
            UserViewController *userViewController = [UserViewController new];
            [userViewController setUid:tempUser.uid];
            [userViewController setUname:tempUser.uname];
            [self.navigationController pushViewController:userViewController animated:YES];
//            [userViewController release];
            
        } else if (indexPath.section == 2){
            SearchTopicModel *tempTopic = [_topicArray objectAtIndex:indexPath.row];
            HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
            web.contentId = tempTopic.contentid;
            web.content = tempTopic.shortcontent;
            web.typeTitle = tempTopic.title;
            [self.navigationController pushViewController:web animated:YES];
//            [web release];
        } else {
            SearchTingModel *tempTing = [_radioArray objectAtIndex:indexPath.row];
            RedioDetailListModel *tempArrayObject = [RedioDetailListModel new];
            //把playInfo传到这个对象里
            //把playInfo的musicUrl传到这个对象里
            //把playInfo的title传到这个对象里
            tempArrayObject.playinfo = tempTing.playinfo;
            tempArrayObject.musicUrl = tempTing.playinfo.musicUrl;
            tempArrayObject.title = tempTing.playinfo.title;
            //构建一个播放radio的详情页Vc
            PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
            [self.navigationController pushViewController:playViewController animated:YES];
//            [playViewController release];
            //为这个Vc设置当前播放的playInfo
            [playViewController setDetailPlayInfo:tempTing.playinfo];
            //为这个VC设置播放列表的model数组  此处因为数据原因仅传入一个进去
            [playViewController setRadioListArrayToPlayer:[NSMutableArray arrayWithObject:tempArrayObject]];
        }
    }  else if ([tableView isEqual:_userTableView]){
        UserInfo *tempUser = [self.userArray objectAtIndex:indexPath.row];
        UserViewController *userViewController = [UserViewController new];
        [userViewController setUid:tempUser.uid];
        [userViewController setUname:tempUser.uname];
        [self.navigationController pushViewController:userViewController animated:YES];
//        [userViewController release];
    } else if ([tableView isEqual:_radioTableView]){
        SearchTingModel *tempTing = [self.radioArray objectAtIndex:indexPath.row];
        RedioDetailListModel *tempArrayObject = [RedioDetailListModel new];
        //把playInfo传到这个对象里
        //把playInfo的musicUrl传到这个对象里
        //把playInfo的title传到这个对象里
        tempArrayObject.playinfo = tempTing.playinfo;
        tempArrayObject.musicUrl = tempTing.playinfo.musicUrl;
        tempArrayObject.title = tempTing.playinfo.title;
        //构建一个播放radio的详情页Vc
        PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
        [self.navigationController pushViewController:playViewController animated:YES];
//        [playViewController release];
        //为这个Vc设置当前播放的playInfo
        [playViewController setDetailPlayInfo:tempTing.playinfo];
        //为这个VC设置播放列表的model数组  此处因为数据原因仅传入一个进去
        [playViewController setRadioListArrayToPlayer:[NSMutableArray arrayWithObject:tempArrayObject]];
    } else if ([tableView isEqual:_topicTableView]){
        SearchTopicModel *tempTopic = [self.topicArray objectAtIndex:indexPath.row];
        HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
        web.contentId = tempTopic.contentid;
        web.content = tempTopic.shortcontent;
        web.typeTitle = tempTopic.title;
        [self.navigationController pushViewController:web animated:YES];
//        [web release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_allTableView]) {
        switch (indexPath.section) {
            case 0:
                return 60;
                break;
            case 1:
                return 60;
                break;
            default:
                return 120;
                break;
        }
    }  else if ([tableView isEqual:_userTableView]){
        return 60;
    } else if ([tableView isEqual:_radioTableView]){
        return 60;
    } else if ([tableView isEqual:_topicTableView]){
        return 120;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_allTableView]) {
        SearchViewTableViewHeader *headerView = [[SearchViewTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, kWidth, 45)];
        switch (section) {
            case 0:
                [headerView.label setText:@"      收藏用户"];
                break;
            case 1:
                [headerView.label setText:@"      收藏Ting"];
                break;
            case 2:
                [headerView.label setText:@"      收藏故事"];
                break;
        }
        
        return headerView;
    } else{
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:_allTableView]) {
        return 45;
    } else{
        return 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
