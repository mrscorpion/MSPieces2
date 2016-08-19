//
//  PiecesPageViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageViewController.h"
#import "PiecesPageLabelViewController.h"
#import "PiecesPageTableViewCell.h"
#import "UserViewController.h"

@interface PiecesPageViewController ()<UIScrollViewDelegate>
@property(nonatomic, retain) UIImageView *fullImageView;
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, assign) NSInteger number;

@end

@implementation PiecesPageViewController
- (void)dealloc{
//    [_array release];
//    [_fullImageView release];
//    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addSwipeGesture];
    self.number = 0;
    NSMutableArray *buttons = [NSMutableArray array];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 4001;
    
    [btn setBackgroundImage:[UIImage imageNamed:@"Pieces_Label"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [buttons addObject:btn];
    [self createNavigationBar:LeftButtonDrawerType andRightButtons:buttons andTitleName:@"碎片"];
    self.array = [NSMutableArray array];
        [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshBoth];

    
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    if (self.backName.length) {
        if (!mjRefresh) {
            [SVProgressHUD show];
        }
        NSString *tagStr = [self.backName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //1.创建NSURLSession对象（可以获取单例对象）
        NSURLSession *session = [NSURLSession sharedSession];
        NSURL *url = [NSURL URLWithString:@"http://api2.pianke.me/timeline/list"];
        //创建一个请求对象，并这是请求方法为POST，把参数放在请求体中传递
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [[NSString stringWithFormat:@"auth=WsBnRCXi8v1DC8h9Ec3im1TJxQMeqZuCK8GZoCm1M0cWP22NFKQh9Y6m30&client=1&deviceid=B7582055-CB79-4179-B4E4-90DC2176DC63&limit=10&start=%ld&tag=%@&version=3.0.6",self.number,tagStr] dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error) {
            if (error) {
                [SVProgressHUD showErrorWithStatus:@"网络连接异常"];
                [self endRefresh];
            } else {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSDictionary *dataDic = [dic objectForKey:@"data"];
                [self aftetGetDataDictionary:dataDic];
                [SVProgressHUD dismiss];
            }
        }];
        
        //3.执行Task
        //注意：刚创建出来的task默认是挂起状态的，需要调用该方法来启动任务（执行任务）
        [dataTask resume];

        
        
        
        
    }else{
        NSString *str = @"http://api2.pianke.me/timeline/list";
        NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" ,@"start" : [NSString stringWithFormat:@"%ld" , self.number] , @"version" : @"3.0.6"};
        [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
            NSDictionary *dataDic = [responseObject objectForKey:@"data"];
            [self aftetGetDataDictionary:dataDic];
        } failureBlock:^(NSError *error) {
            [self endRefresh];
            
        }];

        
    }
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
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PiecesPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableView"];
    cell.piecesPageModel = self.array[indexPath.row];
    [cell.photoButton addTarget:self action:@selector(photoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.image setUserInteractionEnabled:YES];
    [cell.image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
    [cell.image setTag:9999];
    [cell.photoButton setTag:6000 + indexPath.row ];
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
   
- (void)actionTap:(UITapGestureRecognizer *)sender{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    [bgView setBackgroundColor:[UIColor blackColor]];
    [bgView setTag:99999];
    [self.view addSubview:bgView];
//    [bgView release];
    CGPoint location = [sender locationInView:self.fhyTableView];
    NSIndexPath *indexPath = [self.fhyTableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *)[self.fhyTableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:9999];
    cell.contentView.frame = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.fhyTableView.contentOffset.y + 60, imageView.frame.size.width, imageView.frame.size.height);
    
    self.fullImageView = [[UIImageView alloc] init];
    self.fullImageView.backgroundColor = [UIColor blackColor];
    self.fullImageView.userInteractionEnabled = YES;
    [self.fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapTwo:)]];
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (![self.fullImageView superview]) {
        self.fullImageView.image = imageView.image;
        self.fullImageView.frame = cell.contentView.frame;
        [bgView addSubview:self.fullImageView];
        [UIView animateWithDuration:0.5 animations:^{
            self.fullImageView.frame=CGRectMake(0, 0, kWidth, kHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden=YES;
        }];
    }
}


- (void)actionTapTwo:(UITapGestureRecognizer *)sender{
    [[self.view viewWithTag:99999] removeFromSuperview];
    [UIApplication sharedApplication].statusBarHidden=NO;
}


- (void)btnAction:(UIButton *)btn{
    PiecesPageLabelViewController *label = [[PiecesPageLabelViewController alloc] init];
    [self.navigationController pushViewController:label animated:YES];
//    [label release];
}


- (void)photoButtonAction:(UIButton *)button{
    PiecesPageModel *temp = [_array objectAtIndex:button.tag - 6000];
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
