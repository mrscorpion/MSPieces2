//
//  SearchDetailView.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchDetailView.h"
#import "SearchDetailViewSegmentView.h"
#import "SearchViewTableViewHeader.h"

#import "SearchGetTypeModel.h"
#import "UserInfo.h"
#import "PlayInfo.h"
#import "SearchTopicModel.h"
#import "SearchTingModel.h"
#import "RedioDetailListModel.h"

#import "SearchUserCell.h"
#import "SearchTopicCell.h"
#import "SearchTingCell.h"

#import "UserViewController.h"
#import "PlayRadioViewController.h"
#import "HomePageDetailsViewController.h"


@interface SearchDetailView ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,SearchDetailViewSegmentViewDelegate>
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
@property (retain, nonatomic) SearchDetailViewSegmentView *segmentView;
@end

@implementation SearchDetailView

- (void)dealloc
{
//    [_userArray release];
//    [_radioArray release];
//    [_topicArray release];
//    [_allDetailArray release];
//    [_bigScrollView release];
//    [_allTableView release];
//    [_userTableView release];
//    [_radioTableView release];
//    [_topicTableView release];
//    [_segmentView release];
//    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.userArray = [NSMutableArray array];
        self.userPageNumber = 0;
        self.radioArray = [NSMutableArray array];
        self.radioPageNumber = 0;
        self.topicArray = [NSMutableArray array];
        self.topicPageNumber = 0;
    }
    return self;
}

- (void)setAllDetailArray:(NSArray *)allDetailArray{
    if (_allDetailArray != allDetailArray) {
//        [_allDetailArray release];
//        _allDetailArray = [allDetailArray retain];
    }
    [self createSubViews];
}

- (void)createSubViews{
    
    [self createSegmentView];
    [self createScrollView];
    [self createAllTableView];
}

- (void)createSegmentView{
    self.segmentView = [[SearchDetailViewSegmentView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 44)];
    [self.segmentView setDelegate:self];
    NSMutableArray *total = [NSMutableArray array];
    NSInteger allTotalNumber = 0;
    for (SearchGetTypeModel *getTypeModel in _allDetailArray) {
        NSString *totalString = [NSString stringWithFormat:@"%@\n%@", getTypeModel.typename, getTypeModel.total];
        allTotalNumber += [getTypeModel.total integerValue];
        [total addObject:totalString];
    }
    NSString *allTotalString = [NSString stringWithFormat:@"全部\n%ld", allTotalNumber];
    [total insertObject:allTotalString atIndex:0];
    [self.segmentView setTitleContentArray:total];
    [self addSubview:_segmentView];
//    [_segmentView release];
}

- (void)selectButton:(NSInteger)number{
    CGFloat contentOffX = kViewWidth * number;
    if (contentOffX != _bigScrollView.contentOffset.x) {
        [_bigScrollView setContentOffset:CGPointMake(contentOffX, 0) animated:YES];
    }
    NSLog(@"点击了或滑动到了第~~~%ld个button",number);
    if (number == 1 && self.userArray.count == 0) {
        [self createUserTableView];
    } else if (number == 2 && self.radioArray.count == 0){
        [self createTingTableView];
    } else if (number == 3 && self.topicArray.count == 0){
        [self createTopicTableView];
    }
}

- (void)createUserTableView{
    self.userTableView = [[UITableView alloc] initWithFrame:CGRectMake(kViewWidth, 0, kViewWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.userTableView setDelegate:self];
    [self.userTableView setDataSource:self];
    [self.userTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.userTableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.userPageNumber += 10;
        [self getDataWithType:@"user" andPageNumber:_userPageNumber];
    }]];
    [self.bigScrollView addSubview:_userTableView];
    self.userTableView.showsHorizontalScrollIndicator = NO;
    self.userTableView.showsVerticalScrollIndicator = NO;
    [self.userTableView registerNib:[UINib nibWithNibName:@"SearchUserCell" bundle:nil] forCellReuseIdentifier:@"SearchUserCell"];
    [self.userTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_userTableView release];
    [self getDataWithType:@"user" andPageNumber:0];
}

- (void)getDataWithType:(NSString *)typeString andPageNumber:(NSInteger)pageNumber{
    NSString *type = [typeString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:typeString]];
    NSString *word = [self.searchWord stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:self.searchWord]];
    NSDictionary *dic = @{@"auth" : @"", @"client" :@"1", @"deviceid" : @"", @"keyword" : word, @"limit" : @"10", @"start" : [NSString stringWithFormat:@"%ld",pageNumber], @"type" : type, @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:@"http://api2.pianke.me/search/get" parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *allDic = [responseObject objectForKey:@"data"];
        NSArray *listArray = [allDic objectForKey:@"list"];
        if ([typeString isEqualToString:@"user"]) {
            for (NSDictionary *userDic in listArray) {
                UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:userDic];
                [self.userArray addObject:userInfo];
//                [userInfo release];
            }
            [self.userTableView reloadData];
            [self.userTableView.footer endRefreshing];
        } else if ([typeString isEqualToString:@"ting"]){
            for (NSDictionary *tingDic in listArray) {
                SearchTingModel *tingModel = [[SearchTingModel alloc] initWithDictionary:tingDic];
                [self.radioArray addObject:tingModel];
//                [tingModel release];
            }
            [self.radioTableView reloadData];
            [self.radioTableView.footer endRefreshing];
        } else if ([typeString isEqualToString:@"content"]){
            for (NSDictionary *contentDic in listArray) {
                SearchTopicModel *topicModel = [[SearchTopicModel alloc] initWithDictionary:contentDic];
                [self.topicArray addObject:topicModel];
//                [topicModel release];
            }
            [self.topicTableView reloadData];
            [self.topicTableView.footer endRefreshing];
        }

        
    } failureBlock:^(NSError *error) {
        NSLog(@"--1--%@", error);
        
    }];
}


- (void)createTingTableView{
    self.radioTableView = [[UITableView alloc] initWithFrame:CGRectMake(kViewWidth * 2,0, kViewWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.radioTableView setDelegate:self];
    [self.radioTableView setDataSource:self];
    [self.radioTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.radioTableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.radioPageNumber += 10;
        [self getDataWithType:@"ting" andPageNumber:_radioPageNumber];
    }]];
    [self.bigScrollView addSubview:_radioTableView];
    self.radioTableView.showsHorizontalScrollIndicator = NO;
    self.radioTableView.showsVerticalScrollIndicator = NO;
    [self.radioTableView registerNib:[UINib nibWithNibName:@"SearchTingCell" bundle:nil] forCellReuseIdentifier:@"SearchTingCell"];
    [self.radioTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_radioTableView release];
    [self getDataWithType:@"ting" andPageNumber:0];
}

- (void)createTopicTableView{
    self.topicTableView = [[UITableView alloc] initWithFrame:CGRectMake(kViewWidth * 3,0, kViewWidth, _bigScrollView.height) style:UITableViewStylePlain];
    [self.topicTableView setDelegate:self];
    [self.topicTableView setDataSource:self];
    [self.topicTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    [self.topicTableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.topicPageNumber += 10;
        [self getDataWithType:@"content" andPageNumber:_topicPageNumber];
    }]];
    [self.bigScrollView addSubview:_topicTableView];
    self.topicTableView.showsHorizontalScrollIndicator = NO;
    self.topicTableView.showsVerticalScrollIndicator = NO;
    [self.topicTableView registerNib:[UINib nibWithNibName:@"SearchTopicCell" bundle:nil] forCellReuseIdentifier:@"SearchTopicCell"];
    [self.topicTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    [_topicTableView release];
    [self getDataWithType:@"content" andPageNumber:0];
}


- (void)createScrollView{
    self.bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentView.bottom + 1, kViewWidth, kViewHeight - _segmentView.bottom - 1)];
    [self.bigScrollView setPagingEnabled:YES];
    [self.bigScrollView setDelegate:self];
    self.bigScrollView.showsHorizontalScrollIndicator = NO;
    self.bigScrollView.showsVerticalScrollIndicator = NO;
    [self.bigScrollView setContentSize:CGSizeMake(4 * kViewWidth, 0)];
    [self addSubview:_bigScrollView];
//    [_bigScrollView release];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual: _bigScrollView]) {
        NSInteger buttonNumber = scrollView.contentOffset.x / kViewWidth;
        UIButton *button = [self.segmentView viewWithTag:25000 + buttonNumber];
        [self.segmentView segmentButtonAction:button];
    }
}

- (void)createAllTableView{
    self.allTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kViewWidth, _bigScrollView.height) style:UITableViewStylePlain];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:_allTableView]) {
        return 3;
    } else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_allTableView]) {
        if (self.allDetailArray.count) {
            SearchGetTypeModel *temp = [_allDetailArray  objectAtIndex:section];
            return temp.getList.count;
        } else{
            return 0;
        }
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
        SearchGetTypeModel *temp = [self.allDetailArray  objectAtIndex:indexPath.section];
        if ([temp.typename isEqualToString:@"用户"]) {
            SearchUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchUserCell" forIndexPath:indexPath];
            UserInfo *tempUser = [temp.getList objectAtIndex:indexPath.row];
            [cell setCellContent:tempUser];
            return cell;
        } else if ([temp.typename isEqualToString:@"故事"]){
            SearchTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTopicCell" forIndexPath:indexPath];
            SearchTopicModel *tempTopic = [temp.getList objectAtIndex:indexPath.row];
            [cell setCellContent:tempTopic];
            return cell;
        } else {
            SearchTingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTingCell" forIndexPath:indexPath];
            SearchTingModel *tempTing = [temp.getList objectAtIndex:indexPath.row];
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
        SearchGetTypeModel *temp = [_allDetailArray  objectAtIndex:indexPath.section];
        if ([temp.typename isEqualToString:@"用户"]) {
            UserInfo *tempUser = [temp.getList objectAtIndex:indexPath.row];
            UserViewController *userViewController = [UserViewController new];
            [userViewController setUid:tempUser.uid];
            [userViewController setUname:tempUser.uname];
            [_delegate pushAViewController:userViewController];
//            [userViewController release];
            
        } else if ([temp.typename isEqualToString:@"故事"]){
            SearchTopicModel *tempTopic = [temp.getList objectAtIndex:indexPath.row];
            HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
            web.contentId = tempTopic.contentid;
            [_delegate pushAViewController:web];
//            [web release];
        } else {
            SearchTingModel *tempTing = [temp.getList objectAtIndex:indexPath.row];
            RedioDetailListModel *tempArrayObject = [RedioDetailListModel new];
            //把playInfo传到这个对象里
            //把playInfo的musicUrl传到这个对象里
            //把playInfo的title传到这个对象里
            tempArrayObject.playinfo = tempTing.playinfo;
            tempArrayObject.musicUrl = tempTing.playinfo.musicUrl;
            tempArrayObject.title = tempTing.playinfo.title;
            //构建一个播放radio的详情页Vc
            PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
            
            [_delegate pushAViewController:playViewController];
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
        [_delegate pushAViewController:userViewController];
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
        
        [_delegate pushAViewController:playViewController];
//        [playViewController release];
        //为这个Vc设置当前播放的playInfo
        [playViewController setDetailPlayInfo:tempTing.playinfo];
        //为这个VC设置播放列表的model数组  此处因为数据原因仅传入一个进去
        [playViewController setRadioListArrayToPlayer:[NSMutableArray arrayWithObject:tempArrayObject]];
    } else if ([tableView isEqual:_topicTableView]){
        SearchTopicModel *tempTopic = [self.topicArray objectAtIndex:indexPath.row];
        HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
        web.contentId = tempTopic.contentid;
        [_delegate pushAViewController:web];
//        [web release];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_allTableView] && self.allDetailArray.count ) {
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
    if ([tableView isEqual:_allTableView] && self.allDetailArray.count ) {
        SearchViewTableViewHeader *headerView = [[SearchViewTableViewHeader alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 45)];
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

//- (NSMutableArray *)userArray{
//    if (_userArray == nil) {
//        _userArray = [NSMutableArray array];
//    }
//    return _userArray;
//}
//
//- (NSMutableArray *)radioArray{
//    if (_radioArray == nil) {
//        _radioArray = [NSMutableArray array];
//    }
//    return _radioArray;
//}
//
//- (NSMutableArray *)topicArray{
//    if (_topicArray == nil) {
//        _topicArray = [NSMutableArray array];
//    }
//    return _topicArray;
//}

@end
