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

- (NSString *)source {
    NSUInteger start = [_source rangeOfString:@">"].location + 1;
    NSUInteger end = [_source rangeOfString:@"</"].location;
    NSRange subRange = NSMakeRange(start, end - start);
    return [NSString stringWithFormat:@"来自 %@", [_source substringWithRange:subRange]];
}


//本来应该在数据从json(nsdictiong,nsarray)中取出，赋值给模型status。但是采用了mj的第三方模块。现在出现已经处理过的source，进去处理第二遍的问题，原因不明，放弃重写set方法，改get方法中
//- (void)setSource:(NSString *)source {
//    NSRange range = NSMakeRange(0, 0);
//    range.location = [source rangeOfString:@">"].location + 1;
//    range.length = [source rangeOfString:@"</"].location - range.location;
//    //    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch];
//    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
//}

@end
