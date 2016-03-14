//
//  LMweiboUser.h
//  weibo2016
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LMweiboUser : NSObject <NSCoding>

/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　登录注册的时间。*/
//@property (nonatomic, copy) NSString *create_in;
@property (nonatomic, strong) NSDate *create_time;

/** 过期时间*/
@property (nonatomic, copy) NSString *expires_in;

/**　string	登录用户的id*/
@property (nonatomic, copy) NSString *uid;

/**　string	//登录用户的名字（昵称）。*/
@property (nonatomic, copy) NSString *name;

+ (instancetype)weiboUserWithDict:(NSDictionary *)dict;


@end
