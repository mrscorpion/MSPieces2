//
//  UserModel+CoreDataProperties.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/25.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *uname;
@property (nullable, nonatomic, retain) NSString *uid;

@end

NS_ASSUME_NONNULL_END
