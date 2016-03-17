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

/**NSString 微博信息的发布者 */
@property (nonatomic ,copy) NSNumber *mid;


@end
