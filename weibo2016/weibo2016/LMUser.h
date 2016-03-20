//
//  LMUser.h
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface LMUser : NSObject

/** NSString 微博信息的发布者昵称 */
@property (nonatomic ,copy) NSString *name;

/** NSString 微博信息的发布者头像 */
@property (nonatomic ,copy) NSString *profile_image_url;

/** NSString 微博信息的发布者UID */
@property (nonatomic ,copy) NSString *idstr;


@end
