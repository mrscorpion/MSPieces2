//
//  QualityPageViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "QualityPageViewController.h"
#import "QualityPageTableViewCell.h"
#import "QualityPageBuyViewController.h"
#import "HomePageDetailsViewController.h"
@interface QualityPageViewController ()
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, retain) NSDictionary *dataDic;
@property(nonatomic, assign) NSInteger number;

@end

@implementation QualityPageViewController
- (void)dealloc{
//    [_array release];
//    [_dataDic release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.number = 0;
    [self addSwipeGesture];
    [self createNavigationBar:LeftButtonDrawerType andRightButtons:nil andTitleName:@"良品"];
    self.array = [NSMutableArray array];
    [self getDataFromInternet];
    [self createATableView];
    [self addMJRefreshBoth];
    
}


- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/pub/shop";
    NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" ,@"start" : [NSString stringWithFormat:@"%ld" , self.number] , @"version" : @"3.0.6"};
    
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        self.dataDic = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:self.dataDic];
        
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        
    }];
}

- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.number == 0) {
        [self.array removeAllObjects];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    for (NSDictionary *dic in listArray) {
        [self.array addObject:[[QualityPageModel alloc]initWithDictionary: dic]];
        
    }
    
    [self endRefresh];
}

- (void)pull{
    [super pull];
    self.number = 0;
    [self getDataFromInternet];
    
}

- (void)push{
    [super push];
    self.number = self.number + 10;
    [self getDataFromInternet];
}


- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.bottom)];
    [self.fhyTableView setBackgroundColor:[UIColor colorWithWhite:0.969 alpha:1.000]];
    [self.fhyTableView registerClass:[QualityPageTableViewCell class] forCellReuseIdentifier:@"tableView"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QualityPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    cell.qualityPageModel = self.array[indexPath.row];
    [cell.buyButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.buyButton setTag:3000 + indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kWidth - 40) / 2 + 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
    QualityPageModel *tempModel = self.array[indexPath.item];
    web.contentId = tempModel.contentid;
    web.typeTitle = tempModel.title;
    web.content = [NSString stringWithFormat:@"购买地址：%@", tempModel.buyurl];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)buttonAction:(UIButton *)button{
    
    QualityPageModel *temp = [_array objectAtIndex:button.tag - 3000];
    QualityPageBuyViewController *buy = [[QualityPageBuyViewController alloc] init];
    [buy setBuyUrl:temp.buyurl];
    [self.navigationController pushViewController:buy animated:YES];
//    [buy release];
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
