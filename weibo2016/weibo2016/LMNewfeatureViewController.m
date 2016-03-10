//
//  LMNewfeatureViewController.m
//  weibo2016
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMNewfeatureViewController.h"
#import "LMTabBarController.h"

@interface LMNewfeatureViewController ()

@property (nonatomic, weak) UIButton *checkBox;

@end

@implementation LMNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNewfeatureView];
    
}

- (void)addNewfeatureView {

    int imageNum = 4;
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    CGFloat screenW = self.view.bounds.size.width;
    CGFloat screenH = self.view.bounds.size.height;
    for (int i = 0; i < imageNum; i++) {
        NSString *imgName = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imgName]];
        imageView.frame = CGRectMake(screenW * i, 0 , screenW, screenH);
        [scrollView addSubview:imageView];
        if (i == imageNum -1) {
            [self settingUpLastImageView:imageView];
        }
        
    }
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * imageNum, 0);
    scrollView.bounces = NO;//取消弹簧效果
    scrollView.showsHorizontalScrollIndicator = NO;//取消水平的滚动条
    scrollView.showsVerticalScrollIndicator = NO;//取消垂直的滚动条
    scrollView.pagingEnabled = YES;//分页
    [self.view addSubview:scrollView];
}

- (void)settingUpLastImageView:(UIImageView *)imageView {
    CGFloat screenW = self.view.bounds.size.width;
    CGFloat screenH = self.view.bounds.size.height;
    [imageView setUserInteractionEnabled:YES];
    UIButton *checkBox = [[UIButton alloc] init];
    //            checkBox.titleLabel.text = @"分享给大家";//这样是显示不出来的
    [checkBox setTitle:@"分享给大家" forState:UIControlStateNormal];
    checkBox.titleLabel.font = [UIFont systemFontOfSize:14.0];
    checkBox.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    checkBox.bounds = CGRectMake(0, 0, 170, 30);
    checkBox.center = CGPointMake(screenW * 0.5, screenH * 0.65);
    [checkBox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkBox setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [checkBox addTarget:self action:@selector(checkBoxClick) forControlEvents:UIControlEventTouchUpInside];
    self.checkBox = checkBox;
    
    UIButton *finishBtn = [[UIButton alloc] init];
    //            finishBtn.titleLabel.text = @"开始微博";
    [finishBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIImage *finishBtnImg = [UIImage imageNamed:@"new_feature_finish_button"];
    [finishBtn setBackgroundImage:finishBtnImg forState:UIControlStateNormal];
    [finishBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    finishBtn.bounds = CGRectMake(0, 0, finishBtnImg.size.width, finishBtnImg.size.height);
    finishBtn.center = CGPointMake(screenW * 0.5, screenH * 0.70);
    [finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:checkBox];
    [imageView addSubview:finishBtn];
}

- (void)checkBoxClick {
    self.checkBox.selected = !self.checkBox.selected;
}

- (void)finishBtnClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    LMTabBarController *LMweibo = [[LMTabBarController alloc] init];
    window.rootViewController = LMweibo;//2、设置root控制器
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
