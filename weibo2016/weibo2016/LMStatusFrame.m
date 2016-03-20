//
//  LMStatusCellFrame.m
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMStatusFrame.h"

@implementation LMStatusFrame

//重写status属性的set方法.当给其赋值时,计算相关控件的frame
- (void)setStatus:(LMStatus *)status {
    _status = status;
    
    /**微博信息的发布者头像的frame */
    self.profileImageViewFrame = CGRectMake(0, 0, 30, 30);
}

@end
