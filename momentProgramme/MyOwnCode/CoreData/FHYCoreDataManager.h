//
//  FHYCoreDataManager.h
//  CoreDataDemo
//
//  Created by mr.scorpion on 15/11/3.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface FHYCoreDataManager : NSObject


+ (FHYCoreDataManager *)shareManager;
/**
 *  数据管理器
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/**
 *  数据模型器
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/**
 *  连接器
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/**
 *  保存
 */
- (void)saveContext;
/**
 *  获取Document文件路径
 *
 *  @return 路径地址
 */
- (NSURL *)applicationDocumentsDirectory;


@end
