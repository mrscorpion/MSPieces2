//
//  ReadingPageViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "ReadingPageViewController.h"
#import <SDCycleScrollView.h>
#import "ReadingLoopsModel.h"
#import "ReadingCollectionViewCell.h"
#import "ReadingPageDetailsViewController.h"
#import "ReadingPageScrollViewController.h"
#import "ReadingPageWriteViewController.h"
#import "HomePageDetailsViewController.h"
@interface ReadingPageViewController ()<SDCycleScrollViewDelegate , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout>

@property(nonatomic, retain) UICollectionView *collectionView;
@property(nonatomic, retain) SDCycleScrollView *cycleScrollView;
@property(nonatomic, retain) NSMutableArray *loopsUrlArr;
@property(nonatomic, retain) NSDictionary *dataDic;
@property(nonatomic, retain) NSMutableArray *loopsArray;
@property(nonatomic, retain) NSMutableArray *listArray;
@property(nonatomic, retain) NSArray *listArrayOne;
@property(nonatomic, retain) UIImageView *image;
@property(nonatomic, retain) UIView *whiteView;
@property(nonatomic, retain) UIButton *button;
@property(nonatomic, assign) NSInteger number;

@end

@implementation ReadingPageViewController
- (void)dealloc{
//    [_cycleScrollView release];
//    [_loopsUrlArr release];
//    [_collectionView release];
//    [_dataDic release];
//    [_loopsArray release];
//    [_listArray release];
//    [_listArrayOne release];
//    [_image release];
//    [_whiteView release];
//    [_button release];
    [SVProgressHUD dismiss];
//    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigationBar:LeftButtonDrawerType andRightButtons:nil andTitleName:@"阅读"];
    [self addSwipeGesture];
    self.number = 0;
    self.loopsUrlArr = [NSMutableArray array];
    self.loopsArray = [NSMutableArray array];
    self.listArray = [NSMutableArray array];
    self.listArrayOne = [NSArray array];
    [self loops];
    [self createCollectionView];
    [self getDataFromInternet];
    [self createImage];
    [self addMJRefreshPull];
    
    // Do any additional setup after loading the view.
}
- (void)createImage{
    self.whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight / 5)];
    self.whiteView.backgroundColor = [UIColor whiteColor];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(10, 0, kWidth - 20, kHeight / 5);
    [self.button setImage:[UIImage imageNamed:@"Reading_write"] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.whiteView addSubview:self.button ];
    
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth - 20, kHeight / 5)];
    backgroundImage.image = [UIImage imageNamed:@"Reading_Square"];
    [self.button addSubview:backgroundImage];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5, self.button.frame.size.height - 30, self.button.frame.size.width, 30)];
    label.text = @"24小时自由写作 New Writing";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [backgroundImage addSubview:label];
    

//    [self.whiteView release];
//    [backgroundImage release];
//    [label release];
    
}

- (void)buttonAction:(UIButton *)button{
    ReadingPageWriteViewController *write = [[ReadingPageWriteViewController alloc] init];
    [self.navigationController pushViewController:write animated:YES];
//    [write release];
    
}


- (void)getDataFromInternet{
    BOOL mjRefresh = [self.collectionView.header isRefreshing] || [self.collectionView.footer isRefreshing];
        NSString *str = @"http://api2.pianke.me/read/columns";
         NSDictionary *dic = @{@"auth" : @"CZI6Ry7ipf9DC8h8GMLukDJxQMepPOff92hqD2Bm1cWP22NFFTxlY7Pg", @"client" : @"1", @"deviceid" : @"71EBE00C-6E74-48C6-ABBC-EA18D988C5F8", @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:str parameters:dic showHuD:!mjRefresh onView:nil successfulBlock:^(id responseObject) {
        NSDictionary *dataDic = [responseObject objectForKey:@"data"];
        [self aftetGetDataDictionary:dataDic];
        
    } failureBlock:^(NSError *error) {
        [self.collectionView.header endRefreshing];
    }];
    
    
    

    
    
    
}
- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    if (self.number == 0) {
        [self.loopsArray removeAllObjects];
        [self.loopsUrlArr removeAllObjects];
        [self.listArray removeAllObjects];
    }
  
    NSArray *carouselArray = [dictionary objectForKey:@"carousel"];
                 for (NSDictionary *dic in carouselArray) {
                ReadingLoopsModel *loopsModel = [ReadingLoopsModel readingLoopsModelWithDictionary:dic];
                [self.loopsUrlArr addObject:loopsModel.img];
                [self.loopsArray addObject:loopsModel];
                     
            }
    self.cycleScrollView.imageURLStringsGroup = self.loopsUrlArr;
    
    
    
   self.listArrayOne = [dictionary objectForKey:@"list"];
   
    for (NSDictionary *dic in self.listArrayOne) {
        ReadingLoopsModel *loopsModel = [ReadingLoopsModel readingLoopsModelWithDictionary:dic];
        [self.listArray addObject:loopsModel];
    
        
        
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



- (void)loops{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 0, kWidth - 20, (kHeight - self.customNavigationBar.size.height ) / 7 * 2) imageURLStringsGroup:nil];
    [self.cycleScrollView setPageControlAliment:SDCycleScrollViewPageContolAlimentRight];
    self.cycleScrollView.delegate = self;
    
    
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    HomePageDetailsViewController *loops = [[HomePageDetailsViewController alloc] init];
    
    NSRange range = NSMakeRange(17, 24);
    NSString *string = [[(ReadingLoopsModel *)[_loopsArray objectAtIndex:index] url] substringWithRange:range];
    loops.contentId = string;
    [self.navigationController pushViewController:loops animated:YES];
//    [loops release];
    
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *floeLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom,  kWidth, kHeight - self.customNavigationBar.frame.size.height) collectionViewLayout:floeLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self.collectionView registerClass: [ReadingCollectionViewCell class] forCellWithReuseIdentifier:@"collectionView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    
    [self.view addSubview:_collectionView];
//    [_collectionView release];
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
    UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        if (self.loopsArray.count) {
            [reusableView addSubview:self.cycleScrollView];
        }
    
    return reusableView;
    
    }else{
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        if (self.listArray.count) {
            [reusableView addSubview:self.whiteView];
        }
        
        return reusableView;
    }
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kWidth - 20, (kHeight - self.customNavigationBar.size.height ) / 7 * 2);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(kWidth, kHeight / 5);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ReadingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionView" forIndexPath:indexPath];
    
    cell.readingLoops = self.listArray[indexPath.row];
    
    cell.backgroundColor = [UIColor cyanColor];
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

//早安故事点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ReadingPageScrollViewController *details = [[ReadingPageScrollViewController alloc] init];
    details.name = [[self.listArray objectAtIndex:indexPath.item] name];
    details.type = [(ReadingLoopsModel *)[self.listArray objectAtIndex:indexPath.item] type];
    [self.navigationController pushViewController:details animated:YES];
    //[details release];
    
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
