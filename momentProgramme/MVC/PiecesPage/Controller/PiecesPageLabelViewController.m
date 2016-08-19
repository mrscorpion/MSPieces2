//
//  PiecesPageLabelViewController.m
//  momentProgramme
//
//  Created by 王琳 on 15/11/18.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "PiecesPageLabelViewController.h"
#import "PiecesPageCollectionViewCell.h"
#import "PiecesPageLabelDetailsViewController.h"
@interface PiecesPageLabelViewController ()<UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) NSMutableArray *array;
@property(nonatomic, assign) NSInteger number;


@end

@implementation PiecesPageLabelViewController
- (void)dealloc{
//    [_collectionView release];
//    [_array release];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.number = 0;
    self.array = [NSMutableArray array];
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:@"标签"];
    [self createCollectionView];
    [self getDataFromInternet];
    [self addMJRefreshPull];
}

- (void)getDataFromInternet{
    BOOL mjRefresh = [self.collectionView.header isRefreshing] || [self.collectionView.footer isRefreshing];
    NSString *str = @"http://api2.pianke.me/timeline/tags";
    NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg" , @"client" : @"1" , @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8" ,@"limit" : @"10" ,@"start" : [NSString stringWithFormat:@"%ld",self.number] , @"version" : @"3.0.6"};
    
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:dataDic];
        
    } failureBlock:^(NSError *error) {
        [self.collectionView.header endRefreshing];
        
    }];
    

}



- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.number == 0) {
        [self.array removeAllObjects];
    }
    NSArray *listArray = [dictionary objectForKey:@"list"];
    for (NSDictionary *dic in listArray) {
        
        [self.array addObject:[[PiecesPageLabelModel alloc] initWithDictionary:dic]];
        
    }
    
   [self.collectionView reloadData];
    [self.collectionView.header endRefreshing];
   
    
}
- (void)addMJRefreshPull{
    [self.collectionView setHeader:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)]];
}
- (void)pull{
    self.pullOrPush = YES;
    self.number = 0;
    [self getDataFromInternet];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}



- (void)createCollectionView{
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.height) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.collectionView registerClass:[PiecesPageCollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    [self.view addSubview:self.collectionView];
//    [self.collectionView release];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
      return self.array.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PiecesPageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    cell.piecesPageLabelModel = self.array[indexPath.row];
    return cell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kWidth - 30) / 3, (kWidth - 30) / 3);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PiecesPageLabelDetailsViewController *details = [[PiecesPageLabelDetailsViewController alloc] init];
    details.backName = [(PiecesPageLabelModel *)[self.array objectAtIndex:indexPath.item] tag];
    [self.navigationController pushViewController:details animated:YES];
//    [details release];
    
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
