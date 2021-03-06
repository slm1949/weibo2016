//
//  LMStatusCell.m
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMStatusCell.h"
#import "LMTweetToolBar.h"
#import "UIImageView+WebCache.h"

@interface LMStatusCell()

/* 原创微博 */
/**原创微博内容区域 */
@property (nonatomic, weak) UIView *tweetView;
/**微博信息的发布者头像 */
@property (nonatomic, weak) UIImageView *profileImageView;
/**微博信息的发布者昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/**微博会员 */
@property (nonatomic, weak) UIImageView *vipImageView;
/**微博发送时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/**微博发送来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/**微博内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/**转发微博内容区域 */
@property (nonatomic, weak) UIView *retweetView;
/**转发微博信息的发布者昵称 */
@property (nonatomic, weak) UILabel *retweetNameLabel;
/**转发微博内容 */
@property (nonatomic, weak) UILabel *retweetContentLabel;

/**微博工具栏 */
@property (nonatomic, weak) LMTweetToolBar *tweetToolBar;

@end

@implementation LMStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *ID = @"weibo";
    //先从缓冲池中取
    LMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果没有就创建
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//相关控件的创建应该放在初始化的时候
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //初始化原创微博部分控件
    UIView *tweetView = [[UIView alloc] init];
    [self addSubview:tweetView];
    self.tweetView = tweetView;
    
    UIImageView *profileImageView = [[UIImageView alloc] init];
    [tweetView addSubview:profileImageView];
    self.profileImageView = profileImageView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kNameFont;
    [tweetView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *vipImageView = [[UIImageView alloc] init];
    [tweetView addSubview:vipImageView];
    self.vipImageView = vipImageView;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = kTimeFont;
    [tweetView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = kSourceFont;
    sourceLabel.numberOfLines = 0;
    [tweetView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kContentFont;
    contentLabel.numberOfLines = 0;
    [tweetView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    
    //初始化转发微博部分控件
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    [self addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetNameLabel = [[UILabel alloc] init];
//    retweetNameLabel.backgroundColor = [UIColor redColor];
    retweetNameLabel.font = kRetweetNameFont;
    [retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
//    retweetContentLabel.backgroundColor = [UIColor blueColor];
    retweetContentLabel.font = kRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    //初始化微博工具条
    LMTweetToolBar *tweetToolBar = [LMTweetToolBar tweetToolBar];
//    tweetToolBar.backgroundColor = [UIColor yellowColor];
    [self addSubview:tweetToolBar];
    self.tweetToolBar = tweetToolBar;
    
    return self;
}

//传入模型StatusCellFrame时，给相关控件属性及其frame赋值(重写set方法),添加相关控件不能再里面这样就以为着，每重用一次，就会被创建一次，这样的错误的。
- (void)setStatusFrame:(LMStatusFrame *)statusFrame {
    _statusFrame = statusFrame;//固定写法，先给自己的属性赋值
    
    NSURL *url = [NSURL URLWithString:statusFrame.status.user.profile_image_url];
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default"];
    [self.profileImageView sd_setImageWithURL:url placeholderImage:placeholder];
    self.profileImageView.frame = self.statusFrame.profileImageViewFrame;
    
    self.nameLabel.text = statusFrame.status.user.name;
    self.nameLabel.font = kNameFont;
    self.nameLabel.frame = statusFrame.nameLabelFrame;
    
    self.vipImageView.image = [UIImage imageNamed:@"avatar_vip"];
    self.vipImageView.frame = statusFrame.vipImageViewFrame;
    
    self.timeLabel.text = statusFrame.status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelFrame;
    
    self.sourceLabel.text = statusFrame.status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelFrame;
    
    self.contentLabel.text = statusFrame.status.text;
    self.contentLabel.frame = statusFrame.contentLabelFrame;
    
    self.tweetView.frame = statusFrame.tweetViewFrame;
    
    self.retweetNameLabel.text = statusFrame.status.retweeted_status.user.name;
    self.retweetNameLabel.frame = statusFrame.retweetNameLabelFrame;
    
    self.retweetContentLabel.text = statusFrame.status.retweeted_status.text;
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelFrame;
    
    self.retweetView.frame = statusFrame.retweetViewFrame;
    
    [self.tweetToolBar SettingRepostsCount:statusFrame.status.reposts_count commentsCount:statusFrame.status.comments_count attitudesCount:statusFrame.status.attitudes_count];
    self.tweetToolBar.frame = statusFrame.tweetToolBarFrame;
    
}

@end
