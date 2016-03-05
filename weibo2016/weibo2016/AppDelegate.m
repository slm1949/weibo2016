//
//  AppDelegate.m
//  weibo2016
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//1、初始化window
    UITabBarController  *LMweibo = [[UITabBarController alloc] init];
    
    UIViewController *home = [self createController:[[HomeViewController alloc] init] Title:@"首页" imageNamed:@"tabbar_home" selectedImageNamed:@"tabbar_home_selected"];
    UIViewController *message = [self createController:[[MessageViewController alloc] init] Title:@"消息" imageNamed:@"tabbar_message_center" selectedImageNamed:@"tabbar_message_center_selected"];
    UIViewController *discover = [self createController:[[DiscoverViewController alloc] init] Title:@"发现" imageNamed:@"tabbar_discover" selectedImageNamed:@"tabbar_discover_selected"];
    UIViewController *profile = [self createController:[[ProfileViewController alloc] init] Title:@"我" imageNamed:@"tabbar_profile" selectedImageNamed:@"tabbar_profile_selected"];
    
    [LMweibo setViewControllers:@[home,message,discover,profile]];
    
    self.window.rootViewController = LMweibo;//2、设置root控制器
    [self.window makeKeyAndVisible];//3、使window可见
    return YES;
}

-(UIViewController *)createController:(UIViewController *)contr Title:(NSString *)title imageNamed:(NSString *)img selectedImageNamed:(NSString *)selectedImg {
    //设置子控制器的文字和图片
    contr.tabBarItem.title = title;
    contr.navigationItem.title = title;
    contr.tabBarItem.image = [UIImage imageNamed:img];
    contr.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置图片不被系统默认的渲染成蓝色//[UIImage imageNamed:selectedImg];
    //设置文字样式
    NSDictionary *titleColor = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    [contr.tabBarItem setTitleTextAttributes:titleColor forState:UIControlStateSelected];
    UINavigationController *Navc = [[UINavigationController alloc] initWithRootViewController:contr];
    return Navc;
    
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
