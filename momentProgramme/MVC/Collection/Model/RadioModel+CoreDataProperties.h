//
//  RadioModel+CoreDataProperties.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/25.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "RadioModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RadioModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imgUrl;
@property (nullable, nonatomic, retain) NSString *musicUrl;
@property (nullable, nonatomic, retain) NSString *sharepic;
@property (nullable, nonatomic, retain) NSString *sharetext;
@property (nullable, nonatomic, retain) NSString *shareurl;
@property (nullable, nonatomic, retain) NSString *ting_contentid;
@property (nullable, nonatomic, retain) NSString *tingid;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *webview_url;
@property (nullable, nonatomic, retain) NSString *uidUser;
@property (nullable, nonatomic, retain) NSString *iconUser;
@property (nullable, nonatomic, retain) NSString *unameUser;
@property (nullable, nonatomic, retain) NSString *iconAuthor;
@property (nullable, nonatomic, retain) NSString *uidAuthor;
@property (nullable, nonatomic, retain) NSString *unameAuthor;

@end

NS_ASSUME_NONNULL_END
