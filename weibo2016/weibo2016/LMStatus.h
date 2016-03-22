//
//  LMStatus.h
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMUser.h"
@interface LMStatus : NSObject

/**NSString 微博信息的内容 */
@property (nonatomic ,copy) NSString *text;

/**NSString 微博信息的id序号 */
@property (nonatomic ,copy) NSString *idstr;

/**NSString 微博信息的发布者 */
@property (nonatomic ,copy) LMUser *user;

/**NSNumber 微博信息的id */
@property (nonatomic ,copy) NSNumber *mid;

/** NSString 微博信息创建时间 */
@property (nonatomic ,copy) NSString *created_at;

/** NSString 微博信息的来源 */
@property (nonatomic ,copy) NSString *source;

/** 转发的微博 */
@property (nonatomic ,copy) LMStatus *retweeted_status;

/** NSInteger 微博转发数 */
@property (nonatomic ,assign) NSInteger reposts_count;

/** NSInteger 微博评论数 */
@property (nonatomic ,assign) NSInteger comments_count;

/** NSInteger 微博表态数(赞)*/
@property (nonatomic ,assign) NSInteger attitudes_count;

@end
