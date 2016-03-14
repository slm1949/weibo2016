//
//  LMTabBarController.m
//  weibo2016
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMTabBarController.h"

#import "HomeViewController.h"
#import "MessageViewController.h"
#import "DiscoverViewController.h"
#import "ProfileViewController.h"
#import "LMNavigationController.h"
#import "LMTabBar.h"

@interface LMTabBarController ()

@end

@implementation LMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addController:[[HomeViewController alloc] init] Title:@"首页" imageNamed:@"tabbar_home" selectedImageNamed:@"tabbar_home_selected"];
    [self addController:[[MessageViewController alloc] init] Title:@"消息" imageNamed:@"tabbar_message_center" selectedImageNamed:@"tabbar_message_center_selected"];
    [self addController:[[DiscoverViewController alloc] init] Title:@"发现" imageNamed:@"tabbar_discover" selectedImageNamed:@"tabbar_discover_selected"];
    [self addController:[[ProfileViewController alloc] init] Title:@"我" imageNamed:@"tabbar_profile" selectedImageNamed:@"tabbar_profile_selected"];
}



- (void)viewDidAppear:(BOOL)animated {
    [self setValue:[[LMTabBar alloc] init] forKeyPath:@"tabBar"];//self.tabBar = [[LMTabBar alloc] init];//tabbar是readonly
}

-(void)addController:(UIViewController *)contr Title:(NSString *)title imageNamed:(NSString *)img selectedImageNamed:(NSString *)selectedImg {
    //设置子控制器的文字和图片
    contr.title = title;//效果同后面两句//contr.tabBarItem.title = title;   //contr.navigationItem.title = title;
    contr.tabBarItem.image = [UIImage imageNamed:img];
    contr.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//设置图片不被系统默认的渲染成蓝色//[UIImage imageNamed:selectedImg];
    //设置文字样式
    NSDictionary *titleColor = @{NSForegroundColorAttributeName:[UIColor orangeColor]};
    [contr.tabBarItem setTitleTextAttributes:titleColor forState:UIControlStateSelected];
    UINavigationController *Navc = [[LMNavigationController alloc] initWithRootViewController:contr];
    //添加到子控制器
    [self addChildViewController:Navc];
    
//    contr.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
