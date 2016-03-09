//
//  LMDropDownMenu.m
//  weibo2016
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMDropDownMenu.h"

@interface LMDropDownMenu()

@end


@implementation LMDropDownMenu

//以传进来的View为基准弹出下来菜单
- (void)dropDownMenuForView:(UIView *)view {
    //获得最靠前的窗口（最新的）
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    //self自己充当遮盖,添加到window
    self.backgroundColor = [UIColor clearColor];
    self.frame = window.frame;
    [window addSubview:self];
    //菜单容器（就是背景）
    UIImageView *contenter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popover_background"]];
    contenter.bounds = CGRectMake(0, 0, 217, self.content.bounds.size.height);
    CGRect newViewFrame = [view convertRect:view.bounds toView:window];//注意坐标系转换
    contenter.frame = CGRectMake(0, CGRectGetMaxY(newViewFrame), contenter.frame.size.width, contenter.frame.size.height);
    contenter.center = CGPointMake(CGRectGetMidX(newViewFrame), contenter.center.y);
    contenter.userInteractionEnabled = YES;
    //菜单容器里添加内容
    [contenter addSubview:self.content];
    self.content.frame = CGRectMake(10, 15, contenter.frame.size.width - 20, self.content.bounds.size.height);
    [self addSubview:contenter];
}

- (void)setContentController:(UIViewController *)contentController {
    self.content = contentController.view;
    _contentController = contentController;
    
}

//重写UIView的touchesBegan方法,点击遮盖销毁效率的遮盖等
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self dismiss];
}

- (void)dismiss {
    [self.delegate dismissMenu];
    [self removeFromSuperview];
}

@end
