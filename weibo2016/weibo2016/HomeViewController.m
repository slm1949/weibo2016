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

@interface HomeViewController ()<DropDownMenudelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self settingTitleBtn];
    
}

- (void)settingTitleBtn {
    
    self.navigationItem.leftBarButtonItem = [LMItemTool itemToolAddTarget:self action:nil image:@"navigationbar_friendsearch" highlightedImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [LMItemTool itemToolAddTarget:self action:nil image:@"navigationbar_pop" highlightedImage:@"navigationbar_pop_highlighted"];
    
    UIButton *titleBtn = [[UIButton alloc] init];
    titleBtn.bounds = CGRectMake(0, 0, 70, 30);
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//    [titleBtn setBackgroundColor:[UIColor grayColor]];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font =[UIFont systemFontOfSize:17.0];
    [titleBtn addTarget:self action:@selector(titleBtnclick) forControlEvents:UIControlEventTouchUpInside];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
