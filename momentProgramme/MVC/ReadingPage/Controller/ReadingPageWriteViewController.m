//
//  ReadingPageWriteViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/17.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageWriteViewController.h"
#import "ReadingPageWriteTableViewCell.h"
#import "ReadingPageWriteImageTableViewCell.h"
#import "HomePageDetailsViewController.h"
@interface ReadingPageWriteViewController ()
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, assign) NSInteger number;

@end

@implementation ReadingPageWriteViewController
- (void)dealloc{
//    [_array release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.number = 0;
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:@"自由写作"];
    self.array = [NSMutableArray array];
    [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshBoth];
    
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/read/latest";
    NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" , @"sort" : @"addtime" , @"start" : [NSString stringWithFormat:@"%ld" , self.number] , @"version" : @"3.0.6"};
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
        [self.array addObject:[[ReadingPageWriteModel alloc ] initWithDictionary:dic]];
        [self.fhyTableView reloadData];
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
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height)];
    self.fhyTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.fhyTableView registerClass:[ReadingPageWriteTableViewCell class] forCellReuseIdentifier:@"tableView"];
    
    [self.fhyTableView registerClass:[ReadingPageWriteImageTableViewCell class] forCellReuseIdentifier:@"imageTableView"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *image = [self.array[indexPath.item]firstimage];
    
    if (image.length == 0) {
        ReadingPageWriteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
        cell.readingPageWriteModel = self.array[indexPath.row];

        return cell;
    }else{
        ReadingPageWriteImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageTableView"];
        cell.readingPageWriteModel = self.array[indexPath.row];
        return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (kHeight - self.customNavigationBar.frame.size.height) / 4;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
    ReadingPageWriteModel *write = self.array[indexPath.row];
    web.contentId = write.contentid;
    web.typeTitle = write.title;
    web.content = write.shortcontent;
    [self.navigationController pushViewController:web animated:YES];
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
