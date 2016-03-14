//
//  LMweiboUser.m
//  weibo2016
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMweiboUser.h"

@implementation LMweiboUser

+ (instancetype)weiboUserWithDict:(NSDictionary *)dict {
    LMweiboUser *weiboUser = [[self alloc] init];
    weiboUser.access_token = dict[@"access_token"];
     weiboUser.expires_in = dict[@"expires_in"];
    weiboUser.uid = dict[@"uid"];
    weiboUser.create_time = [NSDate date];
    return weiboUser;
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
