//
//  UserViewController.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/19.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//
/*
 NSDictionary *dic = @{@"auth" : @"", @"client" :@"1", @"deviceid" : @
 "", @"uid" : @"102379", @"version" : @"3.0.6"};
 [FHYNetWork handlePOSTWithUrlString:@"http://api2.pianke.me/profile/info" parameters:dic showHuD:NO onView:nil successfulBlock:^(id responseObject) {
 NSLog(@"%@",responseObject);
 } failureBlock:nil];
 */
#import "CustomViewController.h"

@interface UserViewController : CustomViewController

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *uname;
@end
