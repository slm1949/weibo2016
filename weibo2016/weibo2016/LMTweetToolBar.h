//
//  LMTweetToolBar.h
//  weibo2016
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMTweetToolBar : UIView

+ (instancetype)tweetToolBar;

- (void)SettingRepostsCount:(NSInteger)reposts_count commentsCount:(NSInteger)comments_count attitudesCount:(NSInteger)attitudes_count;

@end
