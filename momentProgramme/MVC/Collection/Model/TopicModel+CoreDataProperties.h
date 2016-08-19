//
//  TopicModel+CoreDataProperties.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/25.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TopicModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *contentid;
@property (nullable, nonatomic, retain) NSString *content;

@end

NS_ASSUME_NONNULL_END
