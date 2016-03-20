//
//  LMStatusCellFrame.h
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMStatus.h"

@interface LMStatusFrame : UITableViewCell

@property (nonatomic, strong) LMStatus *status;

/**微博信息的发布者头像的frame */
@property (nonatomic, assign) CGRect profileImageViewFrame;


@end