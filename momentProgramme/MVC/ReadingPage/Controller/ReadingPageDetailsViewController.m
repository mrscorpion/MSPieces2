//
//  ReadingPageDetailsViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/14.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageDetailsViewController.h"
#import "ReadingPageDetailsTableViewCell.h"
#import "ReadingPageHotViewController.h"
#import "HomePageDetailsViewController.h"
@interface ReadingPageDetailsViewController ()

@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, retain) UIButton *btn;
@property(nonatomic, assign) NSInteger readingNumber;
@end

@implementation ReadingPageDetailsViewController
- (void)dealloc{
//    [_array release];
//    [_btn release];
//    [super dealloc];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.readingNumber = 0;
     [self addSwipeGesture];
    self.array = [NSMutableArray array];
    [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshBoth];
    
    // Do any additional setup after loading the view.
}


- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/read/columns_detail";
    NSDictionary *dic =@{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" , @"sort" : @"addtime" , @"start" : [NSString stringWithFormat:@"%ld" , self.readingNumber] , @"typeid" : [NSString stringWithFormat:@"%@" , self.type] , @"version" : @"3.0.6"};
    
    
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:dataDic];
    } failureBlock:^(NSError *error) {
        [self endRefresh];
        
    }];

}

- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.readingNumber == 0) {
        [self.array removeAllObjects];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    for (NSDictionary *dic in listArray) {
        [self.array addObject:[ReadingDetailsModel readingDetailsModelWithDictionary:dic]];
        
    }
    [self endRefresh];
   

    
}


- (void)pull{
    [super pull];
    self.readingNumber = 0;
    [self getDataFromInternet];
    
}

- (void)push{
    [super push];
    self.readingNumber = self.readingNumber + 10;
    [self getDataFromInternet];
    
}



- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, 0, kWidth, kHeight - self.customNavigationBar.bottom - 64)];
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
    return (kWidth - 50) / 4 + 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
    ReadingDetailsModel *detailModel = _array[indexPath.row];
    web.contentId = detailModel.ID;
    web.typeTitle = detailModel.title;
    web.content = web.content;
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
