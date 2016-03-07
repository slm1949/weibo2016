//
//  LMNavigationController.m
//  weibo2016
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMNavigationController.h"

@interface LMNavigationController ()

@end

@implementation LMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//拦截push，重定义导航控制器的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //push的时候隐藏底部栏
        viewController.hidesBottomBarWhenPushed = YES;
        //重定义左边的返回按钮
        UIImage *leftImg = [UIImage imageNamed:@"navigationbar_back"];
        CGSize leftImgSize = leftImg.size;
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, leftImgSize.width, leftImgSize.width)];
        [leftButton setImage:leftImg forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
       //重定义右边的按钮
        UIImage *rightImg = [UIImage imageNamed:@"navigationbar_more"];
        CGSize rightImgSize = rightImg.size;
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, rightImgSize.width, rightImgSize.width)];
        [rightButton setImage:rightImg forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        [rightButton addTarget:self action:@selector(more) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
       
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

- (void)more {
    [self popToRootViewControllerAnimated:YES];
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
