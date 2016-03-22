//
//  LMStatus.m
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMStatus.h"

@implementation LMStatus

- (void)setUser:(LMUser *)user {
    _user = [LMUser mj_objectWithKeyValues:user];
}

- (void)setRetweeted_status:(LMStatus *)retweeted_status {
    _retweeted_status = [LMStatus mj_objectWithKeyValues:retweeted_status];
    _retweeted_status.user.name = [NSString stringWithFormat:@"@%@:",_retweeted_status.user.name];
}

@end
