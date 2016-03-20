//
//  LMStatusCellFrame.m
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMStatusFrame.h"
#import "NSString+Extension.h"

#define kMargin 10

@implementation LMStatusFrame

//重写status属性的set方法.当给其赋值时,计算相关控件的frame
- (void)setStatus:(LMStatus *)status {
    _status = status;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    /*微博信息的发布者头像的frame */
    CGFloat profileImageViewW = 30;
    self.profileImageViewFrame = CGRectMake(kMargin, kMargin, profileImageViewW, profileImageViewW);
    
    /*微博信息的发布者昵称的frame */
    CGFloat nameLabelFrameX = CGRectGetMaxX(self.profileImageViewFrame) + kMargin;
    CGSize nameMaxSize = CGSizeMake(screenW -nameLabelFrameX - kMargin, CGFLOAT_MAX);
    CGSize nameLabelFrameSize =[status.user.name sizeWithFont:kNameFont maxSize:nameMaxSize];
    self.nameLabelFrame  = CGRectMake(nameLabelFrameX, kMargin, nameLabelFrameSize.width, nameLabelFrameSize.height);
    
    /*微博会员图标的frame */
    CGFloat vipImageViewX = CGRectGetMaxX(self.nameLabelFrame);
    CGFloat vipImageViewW = 17.0;
    self.vipImageViewFrame = CGRectMake(vipImageViewX, kMargin, vipImageViewW, vipImageViewW);
    
    /*微博发送时间的frame */
    CGFloat timeLabelY = MAX(CGRectGetMaxY(self.nameLabelFrame), CGRectGetMaxY(self.vipImageViewFrame)) + 5;
    CGSize timeMaxSize = nameMaxSize;
    CGSize timeLabelSize = [status.created_at sizeWithFont:kTimeFont maxSize:timeMaxSize];
    self.timeLabelFrame = CGRectMake(nameLabelFrameX, timeLabelY, timeLabelSize.width, timeLabelSize.height);
    
    /*微博发送来源的frame */
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabelFrame) + kMargin;
    CGSize sourceMaxSize = CGSizeMake(screenW - sourceLabelX - kMargin, CGFLOAT_MAX);
    CGSize sourceLabelSize = [status.source sizeWithFont:kSourceFont maxSize:sourceMaxSize];
    self.sourceLabelFrame = CGRectMake(sourceLabelX, timeLabelY, sourceLabelSize.width, sourceLabelSize.height);
    
    /*微博内容的frame */
    CGFloat contentLabelY = MAX(CGRectGetMaxY(self.profileImageViewFrame), CGRectGetMaxY(self.sourceLabelFrame))  + kMargin;
    CGSize contentMaxSize = CGSizeMake(screenW - 2 * kMargin, CGFLOAT_MAX);
    CGSize contentLabelSize = [status.text sizeWithFont:kContentFont maxSize:contentMaxSize];
    self.contentLabelFrame =CGRectMake(kMargin, contentLabelY, contentLabelSize.width, contentLabelSize.height);
    
    /*微博区域的frame */
    CGFloat tweetViewH = CGRectGetMaxY(self.contentLabelFrame);
    self.tweetViewFrame = CGRectMake(0, 0, screenW, tweetViewH);
    /*cell的frame */
    CGFloat cellViewH = CGRectGetMaxY(self.tweetViewFrame);
    self.cellFrame = CGRectMake(0, 0, screenW, cellViewH);
}

@end


