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
#import "LMWeiboAccount.h"
#import "LMStatus.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#define LMWeiboAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"WeiboAccount.archive"]

@interface HomeViewController ()<DropDownMenudelegate>

@property (nonatomic, strong)NSMutableArray *statuses;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTitleBtn];
    [self loadstatuses];
    
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

- (void)loadstatuses {
    
    LMWeiboAccount *WeiboAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:LMWeiboAccountPath];
    NSString *URLStr = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/home_timeline.json?access_token=%@",WeiboAccount.access_token];
    NSURL *URL = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *statusesDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            NSArray *newStatuses = [LMStatus mj_objectArrayWithKeyValuesArray:statusesDict[@"statuses"]];
            
            NSRange range = NSMakeRange(0, newStatuses.count);
            NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
            [self.statuses insertObjects:newStatuses atIndexes:indexSet];
            
//            for (LMStatus *status in self.statuses) {
//                NSLog(@"微博内容-%@",status.text);
//            }
            [self.tableView reloadData];
            }
            
        }];

    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID = @"status";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        LMStatus *status = self.statuses[indexPath.row];
        cell.textLabel.text = status.user.name;
        cell.detailTextLabel.text = status.text;
        
        NSURL *url = [NSURL URLWithString:status.user.profile_image_url];
        UIImage *placeholder = [UIImage imageNamed:@"avatar_default"];
        [cell.imageView sd_setImageWithURL:url placeholderImage:placeholder];
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
