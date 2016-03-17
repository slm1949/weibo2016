//
//  LMWeiboAccountTool.m
//  weibo2016
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMWeiboAccountTool.h"

#define LMWeiboAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"WeiboAccount.archive"]

@implementation LMWeiboAccountTool

+ (void)saveAccount:(LMWeiboAccount *)weiboAccount {
    
    [NSKeyedArchiver archiveRootObject:weiboAccount toFile:LMWeiboAccountPath];
}

+ (LMWeiboAccount *)weiboAccount {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:LMWeiboAccountPath];
}

@end
