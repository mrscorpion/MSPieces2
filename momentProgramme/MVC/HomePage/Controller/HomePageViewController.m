//
//  HomePageViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomePageTableViewCell.h"
#import "AutoSize.h"
#import "PlayInfo.h"
#import "RedioDetailListModel.h"
#import "PlayRadioViewController.h"
#import "HomePageDetailsViewController.h"
#import "HomePageQuietViewController.h"
@interface HomePageViewController ()

@property(nonatomic, retain) NSMutableArray *array;

@property(nonatomic, assign) NSInteger number;

@property(nonatomic, retain) NSString *date;


@end

@implementation HomePageViewController
- (void)dealloc{
//    [_array release];
//    [_date release];
//    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwipeGesture];
    self.number = 0;
    self.array = [NSMutableArray array];
    
    [self createNavigationBar:LeftButtonDrawerType andRightButtons:nil andTitleName:nil];
    [self createATableView];
    [self getDataFromInternet];
    [self addMJRefreshBoth];

    // Q4: ToDo 无效？
    self.navigationController.hidesBarsOnSwipe = YES;
}



- (void)buttonAction:(UIButton *)button{
    HomePageQuietViewController *quiet = [[HomePageQuietViewController alloc] init];
    [self presentViewController:quiet animated:YES completion:^{
        
    }];
    
}

- (void)btn:(UIButton *)btn{
    [self.customNavigationBar scrollUnderLineToButton: btn];
}

- (void)createATableView{
    [super createATableView];
    [self.fhyTableView setFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height)];
    self.fhyTableView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.fhyTableView registerClass:[HomePageTableViewCell class] forCellReuseIdentifier:@"homeTableView"];
    
    
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.fhyTableView.header isRefreshing] || [self.fhyTableView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/pub/today";
    NSDictionary *dic =  @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" , @"limit"  : @"10 " ,  @"start" : [NSString stringWithFormat:@"%ld" , self.number] , @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        NSString *date = [dataDic objectForKey:@"date"];
        [self.customNavigationBar setTitle:date];
        [self aftetGetDataDictionary:dataDic];
        
    } failureBlock:^(NSError *error) {
        [self endRefresh];
    }];
    

    
}

- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    NSArray *listArray = [dictionary objectForKey:@"list"];
    if (self.number == 0) {
        [self.array removeAllObjects];
    }
    for (NSDictionary *dic in listArray) {
        HomePageModel *homeModel = [[HomePageModel alloc] initWithDictionary:dic];
        if ([homeModel.type isEqualToNumber:@(24)] ||
            [homeModel.type isEqualToNumber:@(10)] ||
            [homeModel.type isEqualToNumber:@(9)] ||
            [homeModel.type isEqualToNumber:@(17)] ||
            [homeModel.type isEqualToNumber:@(6)] ||
            [homeModel.type isEqualToNumber:@(1)] ||
            [homeModel.type isEqualToNumber:@(2)] ||
            [homeModel.type isEqualToNumber:@(14)] ||
            [homeModel.type isEqualToNumber:@(27)] ||
            [homeModel.type isEqualToNumber:@(18)] ||
            [homeModel.type isEqualToNumber:@(29)] ||
            [homeModel.type isEqualToNumber:@(7)] ||
            [homeModel.type isEqualToNumber:@(4)] ) {
             [self.array addObject:homeModel];
        }
    }
    [self endRefresh];
}
- (void)pull{
    [super pull];
    self.number = 0;
    [self getDataFromInternet];
}

- (void)push{
    [super pull];
    self.number = self.number + 10;
    [self getDataFromInternet];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"homeTableView"];
    [cell.image setUserInteractionEnabled:YES];
    [cell.image addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
    cell.homePageModel = self.array[indexPath.row];
    return cell;
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
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:88888];
    cell.contentView.frame = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.fhyTableView.contentOffset.y + 60, imageView.frame.size.width, imageView.frame.size.height);
    
    UIImageView *fullImageView = [[UIImageView alloc] init];
    fullImageView.backgroundColor = [UIColor blackColor];
    fullImageView.userInteractionEnabled = YES;
    [fullImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapTwo:)]];
    fullImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (![fullImageView superview]) {
        fullImageView.image = imageView.image;
        fullImageView.frame = cell.contentView.frame;
        [bgView addSubview:fullImageView];
        [UIView animateWithDuration:0.5 animations:^{
           fullImageView.frame=CGRectMake(0, 0, kWidth, kHeight);
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarHidden=YES;
        }];
    }
}


- (void)actionTapTwo:(UITapGestureRecognizer *)sender{
    [[self.view viewWithTag:99999] removeFromSuperview];
    [UIApplication sharedApplication].statusBarHidden=NO;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *contentStr = [self.array[indexPath.row] content];
    CGFloat contentHeight = [AutoSize AutoSizeOfHeightWithText:contentStr andFont:[UIFont systemFontOfSize:15] andLabelWidth:kWidth - 40];
    
    NSString *imageStr = [self.array[indexPath.row] coverimg_wh];
    if (imageStr.length > 0) {
        NSArray *widthAndHeight = [imageStr componentsSeparatedByString:@"*"];
        CGFloat imageSale = [widthAndHeight[1] floatValue]/ [widthAndHeight[0] floatValue];
        CGFloat imageHeight = imageSale * (kWidth - 40);
        return imageHeight + 190 + contentHeight;
    } else{
       return (kWidth - 40) / 2 + 190 + contentHeight;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HomePageModel *temp = [_array objectAtIndex:indexPath.row];
    if ([temp.type isEqualToNumber:@(2)]) {
        //temp 是你自己的Model  其中要有一个属性是PlayInfo
        //因为要传入数组到处理类中以供所以创建一个RedioDetailListModel的对象
        RedioDetailListModel *tempArrayObject = [RedioDetailListModel new];
        //把playInfo传到这个对象里
        //把playInfo的musicUrl传到这个对象里
        //把playInfo的title传到这个对象里
        tempArrayObject.playinfo = temp.playinfo;
        tempArrayObject.musicUrl = temp.playinfo.musicUrl;
        tempArrayObject.title = temp.playinfo.title;
        //构建一个播放radio的详情页Vc
        PlayRadioViewController *playViewController = [[PlayRadioViewController alloc]init];
        [self.navigationController pushViewController:playViewController animated:YES];
//        [playViewController release];
        //为这个Vc设置当前播放的playInfo
        [playViewController setDetailPlayInfo:temp.playinfo];
        //为这个VC设置播放列表的model数组  此处因为数据原因仅传入一个进去
        [playViewController setRadioListArrayToPlayer:[NSMutableArray arrayWithObject:tempArrayObject]];

    }else{
        HomePageDetailsViewController *details = [[HomePageDetailsViewController alloc] init];
        HomePageModel *homePageModel = self.array[indexPath.row];
        details.contentId = homePageModel.ID;
        details.typeTitle = homePageModel.title;
        details.content = homePageModel.content;
        [self.navigationController pushViewController:details animated:YES];
        //[details release];
        
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
