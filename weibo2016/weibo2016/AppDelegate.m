//
//  AppDelegate.m
//  weibo2016
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "AppDelegate.h"
#import "LMTabBarController.h"
#import "LMNewfeatureViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//1、初始化window
    [self settingUpRootView];//2、设置root控制器

    [self.window makeKeyAndVisible];//3、使window可见
    return YES;
}

- (void)settingUpRootView {
//    NSString *VersionKey = @"Bundle version";//这个是读不出版本号的
//    NSString *VersionKey = @"CFBundleShortVersionString";//和CFBundleVersion到底什么区别
    NSString *VersionKey = @"CFBundleVersion";
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] valueForKey:VersionKey];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *keepVersion = [defaults objectForKey:VersionKey];
    if ([currentVersion isEqualToString:keepVersion]) {
        LMTabBarController *LMweibo = [[LMTabBarController alloc] init];
        self.window.rootViewController = LMweibo;//设置root控制器为微博tabbar控制器
    }else {
        [defaults setObject:currentVersion forKey:VersionKey];//版本号不同就保存到沙盒（偏好设置）里
        [defaults synchronize];
        
        LMNewfeatureViewController *newfeatureVC = [[LMNewfeatureViewController alloc] init];
        self.window.rootViewController = newfeatureVC;//设置root控制器为新特性
    }
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
