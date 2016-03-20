//
//  LMStatusCell.h
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMStatusFrame.h"

@interface LMStatusCell : UITableViewCell

@property (nonatomic, strong) LMStatusFrame *StatusCellFrame;

/**传入tableView获取cell */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
