//
//  LMNavigationController.m
//  weibo2016
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMNavigationController.h"
#import "LMItemTool.h"

@interface LMNavigationController ()

@end

@implementation LMNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)initialize {
//    [super initialize];//为什么不需要调用父类的初始化
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置正常状态下的item风格
    NSDictionary *textAttr = @{NSForegroundColorAttributeName:[UIColor orangeColor],NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    [item setTitleTextAttributes:textAttr forState:UIControlStateNormal];
    //设置不可用状态下的item风格
    NSDictionary *disabletextAttr = @{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:13.0]};
    [item setTitleTextAttributes:disabletextAttr forState:UIControlStateDisabled];
    
}

//拦截push，重定义导航控制器的push操作
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //push的时候隐藏底部栏
        viewController.hidesBottomBarWhenPushed = YES;
        //重定义左边的返回按钮
        viewController.navigationItem.leftBarButtonItem = [LMItemTool itemToolAddTarget:self action:@selector(back) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];
       //重定义右边的按钮
        viewController.navigationItem.rightBarButtonItem = [LMItemTool itemToolAddTarget:self action:@selector(more) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
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
