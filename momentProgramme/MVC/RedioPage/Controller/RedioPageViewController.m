//
//  RedioPageViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioPageViewController.h"
#import <SDCycleScrollView.h>

#import "RedioHotlistModel.h"
#import "RedioListModel.h"
#import "CyclePictureModel.h"

#import "RedioHotListCell.h"
#import "RedioListCell.h"

#import "RedioDetailViewController.h"

@interface RedioPageViewController ()<RedioHotListCellDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, retain) SDCycleScrollView *cycleScrollView;
@property (nonatomic, retain) NSMutableArray *cycleScrollArray;
@property (nonatomic, retain) NSMutableArray *cycleUrlArray;
@property (nonatomic, retain) NSMutableArray *hotListArray;
@property (nonatomic, retain) NSMutableArray *redioArray;
@property (nonatomic, assign) NSInteger redioListNumber;
@end

@implementation RedioPageViewController
- (void)dealloc
{
    [SVProgressHUD dismiss];
//    [_cycleUrlArray release];
//    [_redioArray release];
//    [_cycleScrollArray release];
//    [_hotListArray release];
//    [_cycleScrollView release];
//    [super dealloc];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.redioListNumber = 0;
    [self createNavigationBar:LeftButtonDrawerType andRightButtons:nil andTitleName:@"电台"];
    [self addSwipeGesture];
    [self createATableView];
    [self createACycleScrollView];
    [self initAllArray];
    [self getDataFromInternet];
    [self addMJRefreshBoth];
}

- (void)createACycleScrollView{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidth, kWidth / 2.2) imageURLStringsGroup:nil];
    [self.cycleScrollView setBackgroundColor:[UIColor colorWithWhite:0.969 alpha:1.000]];
    [self.cycleScrollView setDelegate:self];
    [self.cycleScrollView setDotColor:[UIColor whiteColor]];
    [self.cycleScrollView setPageControlAliment:SDCycleScrollViewPageContolAlimentRight];
    [self.fhyTableView setTableHeaderView:_cycleScrollView];
//    [_cycleScrollView release];
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (_cycleScrollArray.count) {
        CyclePictureModel *temp = _cycleScrollArray[index];
        NSString *radioId = [temp.url substringFromIndex:12];
        RedioDetailViewController *detailViewController = [RedioDetailViewController new];
        [detailViewController setRedioId:radioId];
        [self.navigationController pushViewController:detailViewController animated:YES];
//        [detailViewController release];
    }
}

- (void)initAllArray{
    self.cycleScrollArray = [NSMutableArray array];
    self.cycleUrlArray = [NSMutableArray array];
    self.redioArray = [NSMutableArray array];
    self.hotListArray = [NSMutableArray array];
}

- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.bottom)];
    [self.fhyTableView setBackgroundColor:[UIColor colorWithWhite:0.969 alpha:1.000]];
    [self.fhyTableView registerClass:[RedioHotListCell class] forCellReuseIdentifier:@"RedioHotListCell"];
    [self.fhyTableView registerNib:[UINib nibWithNibName:@"RedioListCellXib" bundle:nil] forCellReuseIdentifier:@"RedioListCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _redioArray.count ? _redioArray.count + 1: 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        RedioHotListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedioHotListCell"];
        [cell setDelegate:self];
        if (_hotListArray.count) {
            [cell setImageArray:_hotListArray];
        }
        return cell;
    } else{
        RedioListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedioListCell" forIndexPath:indexPath];
        if (_redioArray.count) {
            RedioListModel *temp = _redioArray[indexPath.row - 1];
            [cell setCellContent:temp];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return (kWidth - 26) / 3 + 36;
    } else{
        return kHeight / 6;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row > 0) {
        if (_redioArray.count) {
            RedioListModel *temp = [_redioArray objectAtIndex:indexPath.row - 1];
            RedioDetailViewController *detailViewController = [RedioDetailViewController new];
            [detailViewController setRedioId:temp.radioid];
            [self.navigationController pushViewController:detailViewController animated:YES];
//            [detailViewController release];
        }
    }
}

- (void)selectedOneHotListButton:(UIButton *)hotButton{
    if (_hotListArray.count) {
        RedioHotlistModel *temp = [_hotListArray objectAtIndex:hotButton.tag - 12000];
        RedioDetailViewController *detailViewController = [RedioDetailViewController new];
        [detailViewController setRedioId:temp.radioid];
        [self.navigationController pushViewController:detailViewController animated:YES];
//        [detailViewController release];
    }
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    [FHYNetworkHandle handlePOSTWithUrlString:[NSString stringWithFormat:@"http://api2.pianke.me/ting/radio%@",self.pullOrPush ? nil : @"_list"] parameters:@{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg", @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" , @"limit" : @"9",@"start" : [NSString stringWithFormat:@"%ld",self.redioListNumber], @"version" : @"3.0.6"} showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:data];
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        NSLog(@"%@",error);
    }];
}

- (void)pull{
    [super pull];
    self.redioListNumber = 0;
    [self getDataFromInternet];
}

- (void)push{
    [super push];
    self.redioListNumber = self.redioListNumber + 9;
    [self getDataFromInternet];
}


- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.redioListNumber == 0) {
        [self.cycleScrollArray removeAllObjects];
        [self.cycleUrlArray removeAllObjects];
        [self.redioArray removeAllObjects];
        [self.hotListArray removeAllObjects];
        for (NSDictionary *cyclePicture in [dictionary objectForKey:@"carousel"]) {
            CyclePictureModel *cycleModel = [[CyclePictureModel alloc] initWithDictionary:cyclePicture];
            [self.cycleScrollArray addObject:cycleModel];
//            [cycleModel release];
            [self.cycleUrlArray addObject:cycleModel.img];
            [self.cycleScrollView setPlaceholderImage:[UIImage imageNamed:@"rectanglePlaceHolder"]];
        }
        [self.cycleScrollView setImageURLStringsGroup:_cycleUrlArray];
        for (NSDictionary *hotList in [dictionary objectForKey:@"hotlist"]) {
            RedioHotlistModel *hotListModel = [[RedioHotlistModel alloc] initWithDictionary:hotList];
            [self.hotListArray addObject:hotListModel];
//            [hotListModel release];
        }
        for (NSDictionary *list in [dictionary objectForKey:@"alllist"]) {
            RedioListModel *listModel = [[RedioListModel alloc] initWithDictionary:list];
            [self.redioArray addObject:listModel];
//            [listModel release];
        }
        [self endRefresh];
    } else{
        for (NSDictionary *list in [dictionary objectForKey:@"list"]) {
            RedioListModel *listModel = [[RedioListModel alloc] initWithDictionary:list];
            [self.redioArray addObject:listModel];
//            [listModel release];
        }
        [self endRefresh];
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
