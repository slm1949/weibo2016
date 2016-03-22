//
//  LMTweetToolBar.m
//  weibo2016
//
//  Created by mac on 16/3/22.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMTweetToolBar.h"

@interface LMTweetToolBar ()

@property (nonatomic, weak)UIView *divideline;
@property (nonatomic, weak)UIButton *repostButton;
@property (nonatomic, weak)UIButton *commentButton;
@property (nonatomic, weak)UIButton *attitudeButton;
@property (nonatomic, weak)UIImageView *line1;
@property (nonatomic, weak)UIImageView *line2;

@end

@implementation LMTweetToolBar

+ (instancetype)tweetToolBar {
    LMTweetToolBar *tweetToolBar = [[super alloc] init];
    return tweetToolBar;
   }

- (instancetype)init {
    self = [super init];
    self.userInteractionEnabled = YES;
    UIView *divideline = [[UIView alloc] init];
    divideline.backgroundColor = [UIColor colorWithRed:200.0/255 green:200.0/255 blue:200.0/255 alpha:1.0];
    [self addSubview:divideline];
    self.divideline = divideline;
    
    UIButton *repostButton = [[UIButton alloc] init];
    [repostButton setImage:[UIImage imageNamed:@"timeline_icon_retweet"] forState:UIControlStateNormal];
    [repostButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:repostButton];
    self.repostButton = repostButton;
    
    UIButton *commentButton = [[UIButton alloc] init];
    [commentButton setImage:[UIImage imageNamed:@"timeline_icon_comment"] forState:UIControlStateNormal];
    [commentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:commentButton];
    self.commentButton = commentButton;
    
    UIButton *attitudeButton = [[UIButton alloc] init];
    [attitudeButton setImage:[UIImage imageNamed:@"timeline_icon_unlike"] forState:UIControlStateNormal];
    [attitudeButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self addSubview:attitudeButton];
    self.attitudeButton = attitudeButton;
    
    UIImageView *line1 = [[UIImageView alloc] init];
    line1.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:line1];
    self.line1 = line1;
    UIImageView *line2 = [[UIImageView alloc] init];
    line2.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:line2];
    self.line2 = line2;
    return self;
}

- (void)layoutSubviews {
    CGSize toolBarSize = self.bounds.size;
    CGFloat lineW = 2;
    CGFloat dividelineH = 0.5;
    self.divideline.frame = CGRectMake(0, 0, toolBarSize.width, dividelineH);
    CGFloat buttonW = (toolBarSize.width - 2 * lineW) / 3;
    self.repostButton.frame = CGRectMake(0, dividelineH, buttonW, toolBarSize.height);
    self.commentButton.frame = CGRectMake(buttonW + lineW, dividelineH, buttonW, toolBarSize.height);
    self.attitudeButton.frame = CGRectMake(2 *(buttonW + lineW), dividelineH, buttonW, toolBarSize.height);
    self.line1.frame = CGRectMake(buttonW, dividelineH, lineW, toolBarSize.height);
    self.line2.frame = CGRectMake(2 * buttonW + lineW, dividelineH, lineW, toolBarSize.height);
}

- (void)SettingRepostsCount:(NSInteger)reposts_count commentsCount:(NSInteger)comments_count attitudesCount:(NSInteger)attitudes_count {
    NSString *reposts = [NSString stringWithFormat:@"%ld",(long)reposts_count];
    NSString *comments = [NSString stringWithFormat:@"%ld",(long)comments_count];
    NSString *attitudes = [NSString stringWithFormat:@"%ld",(long)attitudes_count];
    [self.repostButton setTitle:reposts_count != 0?reposts:@"转发" forState:UIControlStateNormal];
    [self.commentButton setTitle:comments_count != 0?comments:@"评论" forState:UIControlStateNormal];
    [self.attitudeButton setTitle:attitudes_count != 0?attitudes:@"赞" forState:UIControlStateNormal];
}

@end
