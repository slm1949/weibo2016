//
//  LMStatusCellFrame.h
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMStatus.h"

#define kNameFont [UIFont systemFontOfSize:12.0]
#define kTimeFont [UIFont systemFontOfSize:10.0]
#define kSourceFont [UIFont systemFontOfSize:10.0]
#define kContentFont [UIFont systemFontOfSize:15.0]
#define kRetweetNameFont [UIFont systemFontOfSize:14.0]
#define kRetweetContentFont [UIFont systemFontOfSize:14.0]

@interface LMStatusFrame : UITableViewCell

@property (nonatomic, strong) LMStatus *status;

/**微博信息的发布者头像的frame */
@property (nonatomic, assign) CGRect profileImageViewFrame;
/**微博信息的发布者昵称的frame */
@property (nonatomic, assign) CGRect nameLabelFrame;
/**微博会员图标的frame */
@property (nonatomic, assign) CGRect vipImageViewFrame;
/**微博发送时间的frame */
@property (nonatomic, assign) CGRect timeLabelFrame;
/**微博发送来源的frame */
@property (nonatomic, assign) CGRect sourceLabelFrame;
/**微博内容的frame */
@property (nonatomic, assign) CGRect contentLabelFrame;
/*微博区域的frame */
@property (nonatomic, assign) CGRect tweetViewFrame;

/**转发微博信息的发布者昵称的frame */
@property (nonatomic, assign) CGRect retweetNameLabelFrame;
/**转发微博内容的frame */
@property (nonatomic, assign) CGRect retweetContentLabelFrame;
/*转发微博区域的frame */
@property (nonatomic, assign) CGRect retweetViewFrame;

/*微博工具栏的frame */
@property (nonatomic, assign) CGRect tweetToolBarFrame;

/*cell的frame */
@property (nonatomic, assign) CGRect cellFrame;

@end