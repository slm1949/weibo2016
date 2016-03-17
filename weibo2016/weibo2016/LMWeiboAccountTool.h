//
//  LMWeiboAccountTool.h
//  weibo2016
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LMWeiboAccount.h"

@interface LMWeiboAccountTool : NSObject

/** 保存传入的微博账号 */
+ (void)saveAccount:(LMWeiboAccount *)weiboAccount;

/** 解档取出微博账号 */
+ (LMWeiboAccount *)weiboAccount;

@end
