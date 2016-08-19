//
//  ReadingPageHotViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageHotViewController.h"
#import "ReadingPageDetailsTableViewCell.h"
#import "HomePageDetailsViewController.h"
@interface ReadingPageHotViewController ()

@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, assign) NSInteger number;

@end

@implementation ReadingPageHotViewController
- (void)dealloc{
//    [_array release];
    [SVProgressHUD dismiss];
//    [super dealloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    self.number = 0;
    [self createATableView];
    self.array = [NSMutableArray array];
    [self getDataFromInternet];
    [self addMJRefreshBoth];
    
   
    
    // Do any additional setup after loading the view.
}



- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/read/columns_detail";
    NSDictionary *dic =@{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" , @"sort" : @"hot" , @"start" : [NSString stringWithFormat:@"%ld" , self.number] , @"typeid" : [NSString stringWithFormat:@"%@",self.type] , @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:dataDic];
        
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
        [self.array addObject:[ReadingDetailsModel readingDetailsModelWithDictionary:dic]];
        
    }
//    [self.fhyTableView reloadData];
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
    [self.fhyTableView setFrame:CGRectMake(0,self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height)];
    self.fhyTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.fhyTableView registerClass:[ReadingPageDetailsTableViewCell class] forCellReuseIdentifier:@"readingCell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadingPageDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readingCell"];
    cell.readingDetailsModel = self.array[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  (kWidth - 50) / 4 + 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
    ReadingDetailsModel *details = _array[indexPath.row];
    web.contentId = details.ID;
    web.content = details.content;
    web.typeTitle = details.title;
    [self.parentViewController.navigationController pushViewController:web animated:YES];
//    [web release];
    
    
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
