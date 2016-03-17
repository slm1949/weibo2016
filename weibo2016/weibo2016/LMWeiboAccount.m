//
//  LMWeiboAccount.m
//  weibo2016
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMWeiboAccount.h"

@implementation LMWeiboAccount

+ (instancetype)WeiboAccountWithDict:(NSDictionary *)dict {
    LMWeiboAccount *WeiboAccount = [[self alloc] init];
    WeiboAccount.access_token = dict[@"access_token"];
     WeiboAccount.expires_in = dict[@"expires_in"];
    WeiboAccount.uid = dict[@"uid"];
    WeiboAccount.create_time = [NSDate date];
    return WeiboAccount;
}

//注意：归档、解档需要先遵守NScoding协议
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.create_time forKey:@"create_time"];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
//    self = [super initWithCoder:coder];//为什么是系统自动提示的代码竟然报错了？
    self = [super init];
    if (self) {
        self.access_token = [coder decodeObjectForKey:@"access_token"];
        self.expires_in = [coder decodeObjectForKey:@"expires_in"];
        self.uid = [coder decodeObjectForKey:@"uid"];
        self.name = [coder decodeObjectForKey:@"name"];
        self.create_time = [coder decodeObjectForKey:@"create_time"];
    }
    return self;
}

@end
