//
//  AppDelegate.m
//  CarPay
//
//  Created by qianfeng on 16/7/27.
//  Copyright © 2016年 MengHaoRan. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    NSUserDefaults * userInfo = [NSUserDefaults standardUserDefaults];
//    NSInteger count = [userInfo integerForKey:@"appPage"];
//    if (!count) {
//        count = 1;
//    }
   

    if(launchOptions != nil){
    
        UIAlertView * alertV = [[UIAlertView alloc] initWithTitle:@"ALERT" message:[NSString stringWithFormat:@"%@"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertV show];
    }
    
    UILocalNotification * notify = [[UILocalNotification alloc] init];
    notify.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    notify.alertBody = @"ni hao";
    notify.alertTitle = @"notify";
    
    notify.repeatInterval = NSCalendarUnitMinute;
    notify.userInfo = @{@"mykey":@"myValue"};
    
    UIUserNotificationSettings * stting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    
    if (launchOptions == nil) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:stting];
        [[UIApplication sharedApplication] scheduleLocalNotification:notify];
        
        NSUserDefaults * userInfo = [NSUserDefaults standardUserDefaults];
        NSInteger count = [userInfo integerForKey:@"appInfo"];
        
        count ++ ;
        NSLog(@"%ld",count);
        [userInfo setInteger:count forKey:@"appInfo"];
        
        application.applicationIconBadgeNumber = count;


    }
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
//    NSUserDefaults * userInfo = [NSUserDefaults standardUserDefaults];
//    NSInteger count = [userInfo integerForKey:@"appInfo"];
//    
//    count ++ ;
//    NSLog(@"%ld",count);
//    [userInfo setInteger:count forKey:@"appInfo"];
//    
//    application.applicationIconBadgeNumber = count;
    
    UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@",notification] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertV show];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{

    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
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
