//
//  PiecesPageLabelDetailsViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/24.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageLabelDetailsViewController.h"
#import "PiecesPageTableViewCell.h"
#import "UserViewController.h"
@interface PiecesPageLabelDetailsViewController ()

@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, assign) NSInteger number;


@end

@implementation PiecesPageLabelDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.number = 0;
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:self.backName];
    self.array = [NSMutableArray array];
    [self createATableView];
    [self addMJRefreshBoth];
    [self getDataFromInternet];


    
    
    
}


- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
            if (!mjRefresh) {
            [SVProgressHUD show];
        }
    NSLog(@"%@",self.backName);
        NSString *tagStr = [self.backName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",tagStr);
        //1.创建NSURLSession对象（可以获取单例对象）
    NSURLSessionConfiguration *sesss = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:sesss];
        NSURL *url = [NSURL URLWithString:@"http://api2.pianke.me/timeline/list"];
        //创建一个请求对象，并这是请求方法为POST，把参数放在请求体中传递
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[NSString stringWithFormat:@"auth=WsBnRCXi8v1DC8h9Ec3im1TJxQMeqZuCK8GZoCm1M0cWP22NFKQh9Y6m30&client=1&deviceid=B7582055-CB79-4179-B4E4-90DC2176DC63&limit=10&start=%ld&tag=%@&version=3.0.6",self.number,tagStr] dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
                    [self endRefresh];
                } else {
                    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                    NSDictionary *dataDic = [dic objectForKey:@"data"];
                    [self aftetGetDataDictionary:dataDic];
                    [SVProgressHUD dismiss];
                }
            });

        }];
    
       // 3.执行Task
        //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
       [dataTask resume];
}

- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.number == 0) {
        [self.array removeAllObjects];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    for (NSDictionary *dic in listArray) {
        PiecesPageModel *temp = [[PiecesPageModel alloc] initWithDictionary:dic];
        if (![[temp.content substringToIndex:1] isEqualToString:@" "]) {
            [self.array addObject:temp];
        }
//        [temp release];
    }
    [self endRefresh];
    
}
- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height)];
    self.fhyTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.fhyTableView registerClass:[PiecesPageTableViewCell class] forCellReuseIdentifier:@"tableView"];
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count ? _array.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PiecesPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    cell.piecesPageModel = self.array[indexPath.row];
    [cell.photoButton addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.photoButton setTag:9000 + indexPath.row ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *str = [self.array[indexPath.item] coverimg_wh];
    NSString *contentStr = [self.array [indexPath.item] content];
    if (str.length != 0 && contentStr.length != 0) {
        NSArray *widthAndHeight = [str componentsSeparatedByString:@"*"];
        CGFloat hh = [widthAndHeight[1] floatValue]/ [widthAndHeight[0] floatValue];
        CGFloat height = hh * (kWidth - 40);
        
        
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:contentStr andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
        
        
        
        return  20 + 40 + 20  + height + 20 + contentHeight + 10 + 20 + 30 + 1  ;
        
    }
    else if (str.length != 0 && contentStr.length == 0){
        
        NSArray *widthAndHeight = [str componentsSeparatedByString:@"*"];
        CGFloat hh = [widthAndHeight[1] floatValue]/ [widthAndHeight[0] floatValue];
        CGFloat height = hh * (kWidth - 40);
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:contentStr andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
        
        return  20 + 40 + 20  + height + 20 + 10 + 20 + 30 + 1 + contentHeight ;
        
    }
    else{
        
        CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:contentStr andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
        return  20 + 40 + 20 + contentHeight + 10  + 30 + 20 + 1 ;
        
    }
    
    
    
    
}

- (void)photoAction:(UIButton *)button{
    PiecesPageModel *temp = [_array objectAtIndex:button.tag - 9000];
    UserViewController *userViewController = [[UserViewController alloc] init];
    [userViewController setUid:[temp.userinfo objectForKey:@"uid"]];
    [userViewController setUname:[temp.userinfo objectForKey:@"uname"]];
    [self.navigationController pushViewController:userViewController animated:YES];
//    [userViewController release];
    
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
