//
//  RedioDetailViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "RedioDetailViewController.h"

#import "RedioDetailHeaderView.h"
#import "RedioDetailListCell.h"

#import "RedioDetailListModel.h"
#import "PlayInfo.h"
#import "RadioListInfoModel.h"
#import "UserInfo.h"


#import "UserViewController.h"
#import "PlayRadioViewController.h"

@interface RedioDetailViewController ()
@property (nonatomic, retain) NSMutableArray *redioDetailArray;
@property (nonatomic, assign) NSInteger redioDetailListNumber;
@property (nonatomic, retain) RadioListInfoModel *radioListInfo;
@property (nonatomic, retain) RedioDetailHeaderView *detailHeaderView;

@end

@implementation RedioDetailViewController
- (void)dealloc
{
    [SVProgressHUD dismiss];
//    [_detailHeaderView release];
//    [_radioListInfo release];
//    [_redioDetailArray release];
//    [_redioId release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.redioDetailListNumber = 0;
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:nil];
    self.redioDetailArray = [NSMutableArray array];
    [self createDetailHeaderView];
    [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshBoth];
    
}

- (void)createDetailHeaderView{
    self.detailHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"RedioDetailHeaderViewXib" owner:self options:nil] firstObject];
    [self.detailHeaderView setFrame:CGRectMake(0, 0, kWidth, kWidth / 2.1 + 100 )];
}

- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.bottom)];
    [self.fhyTableView setBackgroundColor:[UIColor colorWithWhite:0.969 alpha:1.000]];
    [self.fhyTableView registerNib:[UINib nibWithNibName:@"RedioDetailListCellXib" bundle:nil] forCellReuseIdentifier:@"RedioDetailListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _redioDetailArray.count ? _redioDetailArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth / 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RedioDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RedioDetailListCell"];
    if (_redioDetailArray.count) {
        RedioDetailListModel *temp = _redioDetailArray[indexPath.row];
        [cell setDetailListModel:temp];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_redioDetailArray.count) {
        RedioDetailListModel *temp = _redioDetailArray[indexPath.row];
        PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
        [self.navigationController pushViewController:playViewController animated:YES];
//        [playViewController release];
        [playViewController setDetailPlayInfo:temp.playinfo];
        [playViewController setRadioListArrayToPlayer:self.redioDetailArray];
    }
}



- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSDictionary *parameter = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg", @"client" :@"1", @"deviceid" : @"5F17F991-0D41-4B6E-AAC0-4DC946A29CAD", @"limit" : @"10", @"radioid" :self.redioId, @"start" : [NSString stringWithFormat:@"%ld",self.redioDetailListNumber], @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:[NSString stringWithFormat:@"http://api2.pianke.me/ting/radio_detail%@", self.pullOrPush ? nil : @"_list"] parameters:parameter showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *data = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:data];
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        NSLog(@"%@",error);
    }];
}
- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.redioDetailListNumber == 0) {
        [self.redioDetailArray removeAllObjects];
        self.radioListInfo = [[RadioListInfoModel alloc] initWithDictionary:[dictionary objectForKey:@"radioInfo"]];
        [self.detailHeaderView setRadioListInfo:_radioListInfo];
        [self.detailHeaderView.userIcon addTarget:self action:@selector(headerViewUserIconAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.customNavigationBar setTitle:_radioListInfo.title];
        [self.fhyTableView setTableHeaderView:_detailHeaderView];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    if (listArray.count > 1) {
        for (NSInteger i = _redioDetailListNumber ? 1 : 0; i < listArray.count; i++) {
            RedioDetailListModel *detailListModel = [[RedioDetailListModel alloc] initWithDictionary:listArray[i]];
            [self.redioDetailArray addObject:detailListModel];
//            [detailListModel release];
        }
    }
    [self endRefresh];
}

- (void)headerViewUserIconAction:(UIButton *)button{
    UserInfo *user = _radioListInfo.userInfo;
    UserViewController *userViewController = [UserViewController new];
    [userViewController setUid:user.uid];
    [userViewController setUname:user.uname];
    [self.navigationController pushViewController:userViewController animated:YES];
//    [userViewController release];
}

- (void)pull{
    [super pull];
    self.redioDetailListNumber = 0;
    [self getDataFromInternet];
}

- (void)push{
    [super push];
    self.redioDetailListNumber = self.redioDetailListNumber + 9;
    [self getDataFromInternet];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
