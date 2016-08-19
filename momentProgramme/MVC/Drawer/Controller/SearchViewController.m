//
//  SearchViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/23.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "SearchViewController.h"
#import "HotSearch.h"
#import "PromptModel.h"
#import "UserInfo.h"
#import "PlayInfo.h"
#import "SearchTingModel.h"
#import "SearchTopicModel.h"
#import "RedioDetailListModel.h"
#import "SearchGetTypeModel.h"

#import "PlayRadioViewController.h"


#import "PromptView.h"
#import "SearchDetailView.h"

#import "SearchHotRadioCell.h"
#import "SearchHotTopicCell.h"
#import "HomePageDetailsViewController.h"
@interface SearchViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,PromptViewDelegate,SearchDetailViewDelegate>
@property (retain, nonatomic) UITextField *searchBar;
@property (retain, nonatomic) UITableView *hotTableView;
@property (retain, nonatomic) NSMutableArray *hotModelArray;
@property (retain, nonatomic) UIView *shadowView;
@property (retain, nonatomic) PromptView *promptView;
@property (retain, nonatomic) SearchDetailView *searchDetailView;
@end

@implementation SearchViewController
- (void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
//    [_hotModelArray release];
//    [_searchBar release];
//    [_hotTableView release];
//    [_shadowView release];
//    [_promptView release];
//    [_searchDetailView release];
//    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChanged:) name:UITextFieldTextDidChangeNotification object:_searchBar];
    }
    return self;
}

- (void)textFieldChanged:(id)sender
{
    if (_searchBar.text.length > 0) {
        [self getDataFromInternetForPrompt:_searchBar.text];
        [self.view bringSubviewToFront:self.promptView];
    } else{
        [self.view sendSubviewToBack:self.promptView];
        [self.searchDetailView removeFromSuperview];
    }
}

- (void)getDataFromInternetForPrompt:(NSString *)searchWord{
    NSString *searchContent = [searchWord stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = @{@"auth" : @"", @"client" :@"1", @"deviceid" : @"", @"keyword" : searchContent, @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:@"http://api2.pianke.me/search/suggest" parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        NSArray *array = [responseObject objectForKey:@"data"];
        NSMutableArray *temp = [NSMutableArray array];
        for (NSDictionary *nameDic in array) {
            PromptModel *prompt = [[PromptModel alloc] initWithDictionary:nameDic];
            [temp addObject:prompt];
//            [prompt release];
        }
        [self.promptView setContentArray:temp];
    } failureBlock:^(NSError *error) {
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"searchBg"]]];
    [self createNavigationBar:LeftButtonBackType andRightButtons:nil andTitleName:nil];
    [self createSearchBar];
    [self createShadowView];
    [self createHotTableView];
    [self getDataFromInternetForHotArray];
    [self createPromptView];
}

- (void)selectedLeftButton:(UIButton *)leftButton{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createSearchBar{
    self.searchBar = [[UITextField alloc] initWithFrame:CGRectMake(52, 28, kWidth - 60, 28)];
    [self.searchBar setDelegate:self];
    [self.searchBar setReturnKeyType:UIReturnKeySearch];
    [self.searchBar setFont:[UIFont systemFontOfSize:13]];
    [self.searchBar setClearButtonMode:UITextFieldViewModeWhileEditing];
    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchBarIcon"]];
    [searchIcon setFrame:CGRectMake(0, 0, 20, 20)];
    [self.searchBar setLeftView:searchIcon];
    [self.searchBar setLeftViewMode:UITextFieldViewModeAlways];
//    [searchIcon release];
    [self.searchBar setBorderStyle:UITextBorderStyleRoundedRect];
    [self.searchBar setPlaceholder:@"请键入搜索内容"];
    [self.customNavigationBar addSubview:_searchBar];
//    [_searchBar release];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [textField becomeFirstResponder];
    [self.view bringSubviewToFront:self.shadowView];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self.view sendSubviewToBack:self.shadowView];
    [self.view sendSubviewToBack:self.promptView];
    [self createSearchDetailView];
    return YES;
}

- (void)createShadowView{
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - self.customNavigationBar.bottom)];
    [self.shadowView setBackgroundColor:[UIColor blackColor]];
    [self.shadowView setAlpha:0.5];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenShadowView)];
    [_shadowView addGestureRecognizer:tap];
    [self.view addSubview:_shadowView];
//    [_shadowView release];
}

- (void)hiddenShadowView{
    [self.view sendSubviewToBack:self.shadowView];
    [self.searchBar resignFirstResponder];
}

- (void)createHotTableView{
    self.hotTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.customNavigationBar.bottom, kWidth, kHeight - 64) style:UITableViewStylePlain];
    [self.hotTableView setDelegate:self];
    [self.hotTableView setDataSource:self];
    self.hotTableView.showsHorizontalScrollIndicator = NO;
    self.hotTableView.showsVerticalScrollIndicator = NO;
    [self.hotTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.hotTableView registerNib:[UINib nibWithNibName:@"SearchHotRadioCell" bundle:nil] forCellReuseIdentifier:@"SearchHotRadioCell"];
    [self.hotTableView registerNib:[UINib nibWithNibName:@"SearchHotTopicCell" bundle:nil] forCellReuseIdentifier:@"SearchHotTopicCell"];
    [self.view addSubview:_hotTableView];
//    [_hotTableView release];
    self.hotModelArray = [NSMutableArray array];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hotHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidth, 40)];
    [hotHeaderView setBackgroundColor:[UIColor colorWithWhite:0.937 alpha:1.000]];
    UILabel *hotHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 5, kWidth - 35, 30)];
    [hotHeaderLabel setText:@"他们正在推荐"];
    [hotHeaderLabel setFont:[UIFont systemFontOfSize:15]];
    [hotHeaderView addSubview:hotHeaderLabel];
    return hotHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _hotModelArray.count ? _hotModelArray.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth / 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotSearch *temp = [_hotModelArray objectAtIndex:indexPath.row];
    if ([temp.type isEqualToNumber:@(17)]) {
        SearchHotRadioCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHotRadioCell" forIndexPath:indexPath];
        [cell setCellModel:temp];
        return cell;
    } else {
        SearchHotTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchHotTopicCell" forIndexPath:indexPath];
        [cell setCellModel:temp];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HotSearch *temp = [_hotModelArray objectAtIndex:indexPath.row];
    if ([temp.type isEqualToNumber:@(17)]) {
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
    } else {
        HomePageDetailsViewController *web = [[HomePageDetailsViewController alloc] init];
        web.contentId = temp.contentid;
        [self.navigationController pushViewController:web animated:YES];
//        [web release];
    }

}

- (void)getDataFromInternetForHotArray{
    NSDictionary *dic = @{@"auth" : @"", @"client" :@"1", @"deviceid" : @"", @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:@"http://api2.pianke.me/search/hotlist" parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        [self aftetGetDataArray:[responseObject objectForKey:@"data"]];
    } failureBlock:^(NSError *error) {
        NSLog(@"fff");
    }];
}

- (void)aftetGetDataArray:(NSArray *)array{
    for (NSDictionary *hotSearchDic in array) {
        HotSearch *hotSearch = [[HotSearch alloc] initWithDictionary:hotSearchDic];
        if ([hotSearch.type isEqualToNumber:@(17)] || [hotSearch.type isEqualToNumber:@(1)]) {
            [self.hotModelArray addObject:hotSearch];
        }
//        [hotSearch release];
    }
    [self.hotTableView reloadData];
}

- (void)createPromptView{
    self.promptView = [[PromptView alloc] initWithFrame:_hotTableView.frame];
    [self.promptView setDelegate:self];
    [self.view insertSubview:_promptView belowSubview:_hotTableView];
//    [_promptView release];
}

- (void)selectedCellWithWord:(NSString *)word{
    [self.searchBar setText:word];
    [self.searchBar resignFirstResponder];
    [self.view sendSubviewToBack:self.promptView];
    [self createSearchDetailView];
}

- (void)createSearchDetailView{
    self.searchDetailView = [[SearchDetailView alloc] initWithFrame:_hotTableView.frame];
    [self.searchDetailView setDelegate:self];
    [self.searchDetailView setSearchWord:_searchBar.text];
    [self.view addSubview:_searchDetailView];
//    [_searchDetailView release];
    [self getDataFromInternetForSearchDetailView];
}

- (void)pushAViewController:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)getDataFromInternetForSearchDetailView{
    NSString *searchWord = [_searchBar.text stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = @{@"auth" : @"", @"client" :@"1", @"deviceid" : @"", @"keyword" : searchWord, @"version" : @"3.0.6"};
    [FHYNetworkHandle handlePOSTWithUrlString:@"http://api2.pianke.me/search/index" parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
        NSMutableArray *allDetailArray = [NSMutableArray array];
        NSDictionary *allDic = [responseObject objectForKey:@"data"];
        for (NSDictionary *getTypeModelDic in [allDic objectForKey:@"alldetail"]) {
            if ([[getTypeModelDic objectForKey:@"type"] isEqualToString:@"user"] || [[getTypeModelDic objectForKey:@"type"] isEqualToString:@"content"] || [[getTypeModelDic objectForKey:@"type"] isEqualToString:@"ting"]) {
                SearchGetTypeModel *typeModel = [[SearchGetTypeModel alloc] initWithDictionary:getTypeModelDic];
                typeModel.getList = [NSMutableArray array];
                if ([typeModel.type isEqualToString:@"user"]) {
                    for (NSDictionary *temp in typeModel.list) {
                        UserInfo *userInfo = [[UserInfo alloc] initWithDictionary:temp];
                        [typeModel.getList addObject:userInfo];
//                        [userInfo release];
                    }
                } else if ([typeModel.type isEqualToString:@"content"]){
                    for (NSDictionary *temp in typeModel.list) {
                        SearchTopicModel *topicInfo = [[SearchTopicModel alloc] initWithDictionary:temp];
                        [typeModel.getList addObject:topicInfo];
//                        [topicInfo release];
                    }
                } else if ([typeModel.type isEqualToString:@"ting"]){
                    for (NSDictionary *temp in typeModel.list) {
                        SearchTingModel *tingInfo = [[SearchTingModel alloc] initWithDictionary:temp];
                        [typeModel.getList addObject:tingInfo];
//                        [tingInfo release];
                    }
                }
                [allDetailArray addObject:typeModel];
            }
        }
        [self.searchDetailView setAllDetailArray:allDetailArray];
    } failureBlock:^(NSError *error) {
        
    }];
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
