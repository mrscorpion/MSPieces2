//
//  MethodViewController.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "MethodViewController.h"
#import "TopicModel.h"
#import "UserModel.h"
#import "RadioModel.h"

#import "UserInfo.h"
#import "PlayInfo.h"

@interface MethodViewController ()

@end

@implementation MethodViewController
- (void)dealloc
{
//    [_customNavigationBar release];
//    [_fhyTableView release];
//    [super dealloc];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coreDataManager = [FHYCoreDataManager shareManager];
    self.pullOrPush = YES;
}
//添加手势
- (void)addSwipeGesture{
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipe)];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.view addGestureRecognizer:swipeRight];
//    [swipeRight release];
}
- (void)rightSwipe{
   [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil]; 
}


- (void)createNavigationBar:(LeftButtonType)type andRightButtons:(NSArray *)buttons andTitleName:(NSString *)titleName{
    self.customNavigationBar = [[FHYNavigationBar alloc] initWithWidth:kWidth LeftButtonType:type andRightButtons:buttons andTitleName:titleName];
    [self.customNavigationBar setDelegate:self];
    [self.view addSubview:_customNavigationBar];
//    [_customNavigationBar release];
}

- (void)selectedLeftButton:(UIButton *)leftButton{
    if (leftButton.tag == 11000) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (void)selectedOneRightButton:(UIButton *)rightButton{
    
}

- (void)createATableView{
    self.fhyTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.fhyTableView.showsHorizontalScrollIndicator = NO;
    self.fhyTableView.showsVerticalScrollIndicator = NO;
    [self.fhyTableView setDelegate:self];
    [self.fhyTableView setDataSource:self];
    [self.fhyTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_fhyTableView];
//    [_fhyTableView release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)addMJRefreshBoth{
    [self.fhyTableView setHeader:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)]];
    [self.fhyTableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(push)]];
}

- (void)addMJRefreshPull{
    [self.fhyTableView setHeader:[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pull)]];
}


- (void)addMJRefreshPush{
    [self.fhyTableView setFooter:[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(push)]];
}

- (void)pull{
    if ([self.fhyTableView.footer isRefreshing]) {
        [self.fhyTableView.header endRefreshing];
        return;
    }
    self.pullOrPush = YES;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)push{
    if ([self.fhyTableView.header isRefreshing]) {
        [self.fhyTableView.footer endRefreshing];
        return;
    }
    self.pullOrPush = NO;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)endRefresh{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self.fhyTableView reloadData];
    [self.fhyTableView.header endRefreshing];
    [self.fhyTableView.footer endRefreshing];
}

//根据实体类型插入数据库中
- (void)insertEntityToCoreDataWithEntityName:(EntityName)entityName andObject:(id)object{
    if (entityName == TopicModelType) {
        NSString *entityNameString = @"TopicModel";
        NSDictionary *dic = object;
        TopicModel *topic = [NSEntityDescription insertNewObjectForEntityForName:entityNameString inManagedObjectContext:_coreDataManager.managedObjectContext];
        topic.content = [dic objectForKey:@"content"];
        topic.contentid = [dic objectForKey:@"contentid"];
        topic.title = [dic objectForKey:@"title"];
//        [dic release];
        [_coreDataManager saveContext];
    } else if (entityName == UserModelType){
        NSString *entityNameString = @"UserModel";
        UserInfo *userInfo = object;
        UserModel *user = [NSEntityDescription insertNewObjectForEntityForName:entityNameString inManagedObjectContext:_coreDataManager.managedObjectContext];
        user.uid = [NSString stringWithFormat:@"%@", userInfo.uid];
        user.uname = userInfo.uname;
        user.icon = userInfo.icon;
//        [userInfo release];
        [_coreDataManager saveContext];
    } else if (entityName == RadioModelType){
        NSString *entityNameString = @"RadioModel";
        PlayInfo *playInfo = object;
        RadioModel *radio = [NSEntityDescription insertNewObjectForEntityForName:entityNameString inManagedObjectContext:_coreDataManager.managedObjectContext];
        radio.iconAuthor = playInfo.authorInfo.icon;
        radio.iconUser = playInfo.userInfo.icon;
        radio.uidAuthor = [NSString stringWithFormat:@"%@", playInfo.authorInfo.uid];
        radio.uidUser = [NSString stringWithFormat:@"%@", playInfo.userInfo.uid];
        radio.unameAuthor = playInfo.authorInfo.uname;
        radio.unameUser = playInfo.userInfo.uname;
        radio.imgUrl = playInfo.imgUrl;
        radio.musicUrl = playInfo.musicUrl;
        radio.sharepic = playInfo.sharepic;
        radio.sharetext = playInfo.sharetext;
        radio.shareurl = playInfo.shareurl;
        radio.ting_contentid = playInfo.ting_contentid;
        radio.tingid = playInfo.tingid;
        radio.title = playInfo.title;
        radio.webview_url = playInfo.webview_url;
//        [playInfo release];
        [_coreDataManager saveContext];
    }
}
//根据实体类型查询数据库
- (NSArray *)searchFromCoreDataWithEntityName:(EntityName)entityName{
    NSString *entityNameString;
    if (entityName == TopicModelType) {
        entityNameString = @"TopicModel";
    } else if (entityName == UserModelType){
       entityNameString = @"UserModel";
    } else if (entityName == RadioModelType){
        entityNameString = @"RadioModel";
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityNameString inManagedObjectContext:_coreDataManager.managedObjectContext];
    
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.coreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"%@",error);
    }
    return fetchedObjects;
}
//查询数据库中是否存在相同对象
//UID CONTENTID TINGID
- (BOOL)searchFromCoreDataWithEntityName:(EntityName)entityName andIndentifier:(NSString *)indentifier{
    NSArray *tempArray = [self searchFromCoreDataWithEntityName:entityName];
    if (entityName == TopicModelType) {
        for (TopicModel *topic in tempArray) {
            if ([topic.contentid isEqualToString:indentifier]) {
                return YES;
            }
        }
        return NO;
    } else if (entityName == UserModelType){
        for (UserModel *user in tempArray) {
            if ([user.uid isEqualToString:[NSString stringWithFormat:@"%@",indentifier]]) {
                return YES;
            }
        }
        return NO;
    } else if (entityName == RadioModelType){
        for (RadioModel *radio in tempArray) {
            if ([radio.tingid isEqualToString:indentifier]) {
                return YES;
            }
        }
        return NO;
    } else{
        return NO;
    }
}
//根据对象删除数据库中内容
- (void)deleteEntityObjectWithObject:(id)Object andEntityName:(EntityName)entityName{
    NSArray *tempArray = [self searchFromCoreDataWithEntityName:entityName];
    if (entityName == TopicModelType) {
        NSDictionary *dic = Object;
        for (TopicModel *topic in tempArray) {
            if ([topic.contentid isEqualToString:[dic objectForKey:@"contentid"]]) {
                [_coreDataManager.managedObjectContext deleteObject:topic];
                break;
            }
        }
//        [dic release];
    } else if (entityName == UserModelType){
        UserInfo *userInfo = Object;
        for (UserModel *user in tempArray) {
            if ([user.uid isEqualToString:[NSString stringWithFormat:@"%@", userInfo.uid]]) {
                [_coreDataManager.managedObjectContext deleteObject:user];
                break;
            }
        }
//        [userInfo release];
    } else if (entityName == RadioModelType){
        PlayInfo *playInfo = Object;
        for (RadioModel *radio in tempArray) {
            if ([radio.tingid isEqualToString:playInfo.tingid]) {
                [_coreDataManager.managedObjectContext deleteObject:radio];
                break;
            }
        }
//        [playInfo release];
    }
    [_coreDataManager saveContext];
}


//分享方法
- (void)shareWithContent:(NSString *)content andButton:(UIButton *)sender{
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:@"我正在EosWing App浏览故事和电台。"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"EosWing"
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    [container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

- (void)getDataFromInternet{
    
}

- (void)aftetGetDataArray:(NSArray *)array{
    
}

- (void)aftetGetDataDictionary:(NSDictionary *)dictionary{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
