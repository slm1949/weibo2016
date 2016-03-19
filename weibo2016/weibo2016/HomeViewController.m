//
//  HomeViewController.m
//  weibo2016
//
//  Created by mac on 16/3/5.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "HomeViewController.h"
#import "LMItemTool.h"
#import "LMDropDownMenu.h"
#import "HomeTitleMenuController.h"
#import "HomeTitleButton.h"
#import "LMWeiboAccountTool.h"
#import "LMStatus.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"

@interface HomeViewController ()<DropDownMenudelegate>

@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTitleBtn];
    [self pullDownRefresh];//下拉刷新数据
    [self pullUpLoadMore];//上拉加载更多数据
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(unread_count) userInfo:nil repeats:YES];//定时获得微博未读数
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)pullDownRefresh {
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [self.view addSubview:refresh];//tableview集成刷新控件
    [refresh addTarget:self action:@selector(loadstatuses:) forControlEvents:UIControlEventValueChanged];
    
}

- (void)pullUpLoadMore {
    
    UIButton *refresh = [[UIButton alloc] init];
    refresh.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40);
    refresh.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [refresh setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refresh setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [refresh addTarget:self action:@selector(pullUpWithButton:) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableFooterView = refresh;
    if (self.statuses.count == 0) {
        refresh.hidden = YES;
    }

}

//懒加载微博数据,重写get方法,注意懒加载的标准写法
- (NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [[NSMutableArray alloc] init];
    }
    return _statuses;
}

- (void)settingTitleBtn {
    //设置首页左侧按钮
    self.navigationItem.leftBarButtonItem = [LMItemTool itemToolAddTarget:self action:nil image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    //设置首页右侧按钮
    self.navigationItem.rightBarButtonItem = [LMItemTool itemToolAddTarget:self action:nil image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
   //设置首页中间title按钮
    UIButton *titleBtn = [[HomeTitleButton alloc] init];
    titleBtn.bounds = CGRectMake(0, 0, 200, 30);//不应该设置在layoutsubview里，容易造成循环调用2.设置了系统也会对frame做调整（这可能就是当title字多的时候循环引用的原因3不写又不能正常显示
    
    [titleBtn addTarget:self action:@selector(titleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
}

- (void)titleBtnclick {
    UIButton *titleBtn =(UIButton *)self.navigationItem.titleView;
    titleBtn.selected = YES;
    LMDropDownMenu *menu = [[LMDropDownMenu alloc] init];
    menu.contentController = [[HomeTitleMenuController alloc] init];
    CGRect tempFrame = menu.contentController.view.frame;
    menu.contentController.view.bounds = CGRectMake(0, 0, tempFrame.size.width, 44*3);
    menu.delegate = self;
    [menu dropDownMenuForView:titleBtn];
}

- (void)dismissMenu {
    UIButton *titleBtn =(UIButton *)self.navigationItem.titleView;
    titleBtn.selected = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载微博信息
- (void)loadstatuses:(UIRefreshControl *)refresh {//把刷新控件作为控件传进来,为下面代码使用

    // 1.session管理者
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 2.拼接请求参数
    LMWeiboAccount *account = [LMWeiboAccountTool weiboAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    LMStatus *firstStatus = [self.statuses firstObject];
    if (firstStatus) {
        params[@"since_id"] = firstStatus.mid;
    }
    // 3.发送请求
    [session GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组转模型数组
        NSArray *newStatuses = [LMStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSRange range = NSMakeRange(0, newStatuses.count);
        
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatuses atIndexes:indexSet];
        [refresh endRefreshing];//结束刷新控件刷新状态
        [self.tableView reloadData];//刷新表格
        [self showNewStatusesCount:newStatuses.count];//提示刷新微博的数量
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [refresh endRefreshing];//结束刷新控件刷新状态
//        NSLog(@"%@",error);
    }];
}

- (void)showNewStatusesCount:(NSInteger)count {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 34, self.view.bounds.size.width, 30);
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%ld条新微博",(long)count];
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, 30);
    } completion:^(BOOL finished) {
        //延时停留1s后再退回
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
        
    }];
}

- (void)pullUpWithButton:(UIButton *)refresh {
    [refresh setTitle:@"正在加载中" forState:UIControlStateNormal];
    refresh.enabled = NO;
    
    // 1.session管理者
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 2.拼接请求参数
    LMWeiboAccount *account = [LMWeiboAccountTool weiboAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    LMStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        //max_id 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        long long max_id = [lastStatus.mid longLongValue] - 1;
        params[@"max_id"] = @(max_id);
    }
    // 3.发送请求
    [session GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //字典数组转模型数组
        NSArray *newStatuses = [LMStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        [self.statuses addObjectsFromArray:newStatuses];
        //还原footer的状态
        [refresh setTitle:@"点击加载更多" forState:UIControlStateNormal];
        refresh.enabled = YES;
        [self.tableView reloadData];//刷新表格
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //还原footer的状态
        [refresh setTitle:@"点击加载更多" forState:UIControlStateNormal];
        refresh.enabled = YES;
    }];
    
}

- (void)unread_count {
    
    //ios8.0+显示应用程序角标，需要下面两行代码
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    // 1.session管理者
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    // 2.拼接请求参数
    LMWeiboAccount *account = [LMWeiboAccountTool weiboAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    // 3.发送请求
    [session GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSNumber *badgeValue = responseObject[@"status"];
        if ([badgeValue isEqualToNumber:@(0)]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else {
            self.tabBarItem.badgeValue = [badgeValue stringValue];
            [UIApplication sharedApplication].applicationIconBadgeNumber = [badgeValue integerValue];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //错误信息处理
    }];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.statuses.count > 0) {
        self.tableView.tableFooterView.hidden = NO;
    }
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"status";
    //先从缓冲池中取
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果没有就创建
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    //设置cell中的数据，之前放到if{}内设置，是非常错误的
    LMStatus *status = self.statuses[indexPath.row];
    cell.textLabel.text = status.user.name;
    cell.detailTextLabel.text = status.text;
    NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default"];
    [cell.imageView sd_setImageWithURL:url placeholderImage:placeholder];
//    NSLog(@"微博内容-%@",cell.detailTextLabel.text);
    return cell;
}

@end
