//
//  AppDelegate.m
//  momentProgramme
//
//  Created by mr.scorpion on 15/11/12.
//  Copyright © 2015年 mr.scorpion. All rights reserved.
//

#import "AppDelegate.h"
#import "DrawerViewController.h"
#import <MMDrawerController.h>
#import <MMDrawerVisualState.h>
#import <AVFoundation/AVFoundation.h>
#import "StreamKitHandle.h"
#import "FHYCoreDataManager.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "WeiboSDK.h"

#import "PKLaunchingViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
- (void)dealloc
{
//    [_window release];
//    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [NSThread sleepForTimeInterval:1];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    DrawerViewController *drawerViewController = [[DrawerViewController alloc] init];
//    [FHYNetworkHandle startMonitoringNetworkStatus];
//    MMDrawerController *root = [[MMDrawerController alloc] initWithCenterViewController:drawerViewController.viewControllers[0] leftDrawerViewController:drawerViewController];
//    [drawerViewController release];
//    [root setShowsShadow:NO];
//    [root setMaximumLeftDrawerWidth:220];
//    [root setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
//    [root setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    [root setDrawerVisualStateBlock:[MMDrawerVisualState slideVisualStateBlock]];
//    [self.window setRootViewController:root];
//    [root release];
//    
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;
    PKLaunchingViewController *launchVC = [[PKLaunchingViewController alloc] init];
    self.window.rootViewController = launchVC;
    [self.window makeKeyAndVisible];
    
    [FHYNetworkHandle startMonitoringNetworkStatus];
    
    NSError* error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    
    NSLog(@"CoreData沙盒地址%@", [[FHYCoreDataManager shareManager] applicationDocumentsDirectory]);
#pragma mark 分享SDK
    [ShareSDK registerApp:@"c9bc140831a0"];
    [ShareSDK connectSinaWeiboWithAppKey:@"2008548324" appSecret:@"9284678a0248575c9397628f2e829c59" redirectUri:@"http://www.sharesdk.cn"];
    [ShareSDK connectSinaWeiboWithAppKey:@"r2008548324"  appSecret:@"9284678a0248575c9397628f2e829c59" redirectUri:@"http://www.sharesdk.cn" weiboSDKCls:[WeiboSDK class]];
    [ShareSDK connectWeChatWithAppId:@"wx4d27d4098052662a"
                           appSecret:@"d4624c36b6795d1d99dcf0547af5443d"
                           wechatCls:[WXApi class]];
    //连接邮件
    [ShareSDK connectMail];
    return YES;
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //StreamKitHandle是我为播放器写的单例，这段就是当音乐还在播放状态的时候，给后台权限，不在播放状态的时候，收回后台权限
    if ([StreamKitHandle shareStreamKitHandle].player.state == STKAudioPlayerStatePlaying) {
        //有音乐播放时，才给后台权限，不做流氓应用。
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
        //开启定时器
        [[StreamKitHandle shareStreamKitHandle] beginConfigPlayingInfoTimer];
    }
    else
    {
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        [self resignFirstResponder];
        //检测是都关闭定时器
        [[StreamKitHandle shareStreamKitHandle] endConfigPlayingInfoTimer];
    }
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    StreamKitHandle *handle = [StreamKitHandle shareStreamKitHandle];
    if (event.type == UIEventTypeRemoteControl) {
        
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause:
                //点击了暂停
                [handle pause];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                //点击了下一首
                [handle playNext];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                //点击了上一首
                [handle playLast];
                //此时需要更改歌曲信息
                break;
            case UIEventSubtypeRemoteControlPlay:
                //点击了播放
                [handle resume];
                break;
            default:
                break;
        }
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[StreamKitHandle shareStreamKitHandle] endConfigPlayingInfoTimer];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[FHYCoreDataManager shareManager] saveContext];
}

@end
