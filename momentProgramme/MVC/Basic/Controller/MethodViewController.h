//
//  MethodViewController.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "FHYNavigationBar.h"
typedef CF_ENUM (NSInteger,  EntityName) {
    TopicModelType = 0,
    UserModelType,
    RadioModelType
};

@interface MethodViewController : BSViewController<UITableViewDataSource,UITableViewDelegate, FHYNavigationBarDelegate>
@property (retain, nonatomic) UITableView *fhyTableView;
@property (retain, nonatomic) FHYNavigationBar *customNavigationBar;
@property (nonatomic, assign) BOOL pullOrPush;
@property (nonatomic,strong)FHYCoreDataManager *coreDataManager;


//创建NavigationBar
- (void)createNavigationBar:(LeftButtonType)type andRightButtons:(NSArray *)buttons andTitleName:(NSString *)titleName;
//创建TableView重复代码
- (void)createATableView;
//添加呼出左侧抽屉手势
- (void)addSwipeGesture;
//添加刷新与加载
- (void)addMJRefreshBoth;
//只添加刷新
- (void)addMJRefreshPull;
//只添加加载
- (void)addMJRefreshPush;
//下拉刷新
- (void)pull;
//上拉加载
- (void)push;
//结束刷新
- (void)endRefresh;

//根据实体类型插入数据库中
- (void)insertEntityToCoreDataWithEntityName:(EntityName)entityName andObject:(id)object;
//根据实体类型查询数据库
- (NSArray *)searchFromCoreDataWithEntityName:(EntityName)entityName;
//查询数据库中是否存在相同对象
//UID CONTENTID TINGID
- (BOOL)searchFromCoreDataWithEntityName:(EntityName)entityName andIndentifier:(NSString *)indentifier;
//根据对象删除数据库中内容
- (void)deleteEntityObjectWithObject:(id)Object andEntityName:(EntityName)entityName;

//分享方法
- (void)shareWithContent:(NSString *)content andButton:(UIButton *)sender;


//省着写系列之使用网络连接
- (void)getDataFromInternet;
//省着写系列之拿到数据后处理成Model
- (void)aftetGetDataArray:(NSArray *)array;
- (void)aftetGetDataDictionary:(NSDictionary *)dictionary;
@end
