//
//  PlayInfo.h
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/15.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "BSModel.h"
@class UserInfo;
@interface PlayInfo : BSModel
/**
 *  图片地址
 */
@property (copy, nonatomic) NSString *imgUrl;
/**
 *  音乐地址
 */
@property (copy, nonatomic) NSString *musicUrl;
/**
 * 分享照片
 */
@property (copy, nonatomic) NSString *sharepic;
/**
 *  分享文字
 */
@property (copy, nonatomic) NSString *sharetext;
/**
 *  分享地址
 */
@property (copy, nonatomic) NSString *shareurl;
/**
 *  ting_contentid
 */
@property (copy, nonatomic) NSString *ting_contentid;
/**
 *  tingid
 */
@property (copy, nonatomic) NSString *tingid;
/**
 *  标题
 */
@property (copy, nonatomic) NSString *title;
/**
 *  webViewURL
 */
@property (copy, nonatomic) NSString *webview_url;
/**
 *  userinfo
 */
@property (retain, nonatomic) UserInfo *userInfo;
/**
 *  authorInfo
 */
@property (retain, nonatomic) UserInfo *authorInfo;
@end
