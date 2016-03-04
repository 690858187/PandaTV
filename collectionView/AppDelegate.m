//
//  AppDelegate.m
//  collectionView
//
//  Created by 1234 on 15/12/4.
//  Copyright © 2015年 XDBB. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "SubcateViewController.h"
#import "LiveViewController.h"
#import "MyViewController.h"
//share sdk
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
//#import "UMSocialAlipayShareHandler.h"
#import "UMSocialQQHandler.h"
// UM PUSH
#import "UMessage.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000


@interface AppDelegate ()<UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // third
    [self addThird];
    [self addUMPushWithOptions:launchOptions];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    HomeViewController    *vc_1 = [[HomeViewController alloc] init];
    vc_1.title = @"首页";
    SubcateViewController *vc_2 = [[SubcateViewController alloc] init];
    vc_2.title = @"栏目";
    LiveViewController    *vc_3 = [[LiveViewController alloc] init];
    vc_3.title = @"直播";
    MyViewController      *vc_4 = [[MyViewController alloc] init];
    vc_4.title = @"我的";
    BaseNavigationController *nav_vc_1 = [[BaseNavigationController alloc] initWithRootViewController:vc_1];
    nav_vc_1.tabBarItem.image = [UIImage imageNamed:@"home"];
    nav_vc_1.tabBarItem.selectedImage = [UIImage imageNamed:@"home_pressed"];
    BaseNavigationController *nav_vc_2 = [[BaseNavigationController alloc] initWithRootViewController:vc_2];
    nav_vc_2.tabBarItem.image = [UIImage imageNamed:@"column"];
    nav_vc_2.tabBarItem.selectedImage = [UIImage imageNamed:@"column_pressed"];
    BaseNavigationController *nav_vc_3 = [[BaseNavigationController alloc] initWithRootViewController:vc_3];
    nav_vc_3.tabBarItem.image = [UIImage imageNamed:@"live"];
    nav_vc_3.tabBarItem.selectedImage = [UIImage imageNamed:@"live_pressed"];
    UINavigationController *nav_vc_4 = [[UINavigationController alloc] initWithRootViewController:vc_4];
    nav_vc_4.tabBarItem.image = [UIImage imageNamed:@"user"];
    nav_vc_4.tabBarItem.selectedImage = [UIImage imageNamed:@"user_pressed"];
    nav_vc_4.navigationBar.barTintColor = kBackColor_tone;
    [nav_vc_4.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:16],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航栏背景图片
    [[UINavigationBar appearance] setBarTintColor:kBackColor_tone];
    //去掉导航栏底部黑线
    [nav_vc_4.navigationBar setBackgroundImage:[Common imageWithColor:kBackColor_tone size:CGSizeMake(1, 1)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    [nav_vc_4.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                                                     [UIFont systemFontOfSize:17], NSFontAttributeName,
                                                                     nil]];
    UITabBarController *tabBarVC = [[UITabBarController alloc] init];
    tabBarVC.delegate = self;
    tabBarVC.viewControllers = @[nav_vc_1,nav_vc_2,nav_vc_3,nav_vc_4];
    self.window.rootViewController = tabBarVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}
/**
 *  第三方
 */
- (void)addThird {
    
    [UMSocialData setAppKey:UMAppKey];
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxdc1e388c3822c80b" appSecret:@"a393c1527aaccb95f3a4c88d6d1455f6" url:@"http://www.umeng.com/social"];
    // 设置支付宝分享的appId
   // [UMSocialAlipayShareHandler setAlipayShareAppId:@"2015111700822536"];
    //    //设置分享到QQ空间的应用Id，和分享url 链接
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    //    //设置支持没有客户端情况下使用SSO授权
    [UMSocialQQHandler setSupportWebView:YES];
   
}

- (void)addUMPushWithOptions:(NSDictionary *)launchOptions {
    //set AppKey and AppSecret
    [UMessage startWithAppkey:APPPushKey launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];

}


- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"DeviceToken:%@",deviceToken] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    NSLog(@"%@",deviceToken);
    [alert show];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //如果注册不成功，打印错误信息，可以在网上找到对应的解决方案
    //如果注册成功，可以删掉这个方法
    NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    //  [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    //可以捕捉后台发送信息userInfo的变化，定制弹出页面，或者触发声音以及界面展示或者push到指定页面
    
//        self.userInfo = userInfo;
//        //定制自定的的弹出框
//        if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//        {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
//                                                                message:@"Test On ApplicationStateActive"
//                                                               delegate:self
//                                                      cancelButtonTitle:@"确定"
//                                                      otherButtonTitles:nil];
//            [alertView show];
//    
//        }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
