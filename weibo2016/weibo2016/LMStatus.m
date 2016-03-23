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

/**
 1.今年
 1> 今天
 * 1分内： 刚刚
 * 1分~59分内：xx分钟前
 * 大于60分钟：xx小时前
 
 2> 昨天
 * 昨天 xx:xx
 
 3> 其他
 * xx-xx xx:xx
 
 2.非今年
 1> xxxx-xx-xx xx:xx
 */
- (NSString *)created_at {
    //设置转换格式,Tue May 31 17:46:55 +0800 2011
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //注意：如果有中文的月 年 周等（或者英文的） 需要设置locale。//中文zh_CN
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    //NSString转NSDate
    NSDate *date=[formatter dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    
    
    if ([self isThisYearWithDate:date now:now]) {
        if ([self isTodayWithDate:date now:now]) {
            NSDateComponents *cmps = [self compareWithDate:date now:now];
            if (cmps.hour == 0 && cmps.minute == 0) {//* 1分内： 刚刚
                return @"刚刚";
            }else if (cmps.hour == 0) {//* 1分~59分内：xx分钟前
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }else {//* 大于60分钟：xx小时前
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }
            
        }else if ([self isYesterdayWithDate:date now:now]) {//昨天
            formatter.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天%@", [formatter stringFromDate:date]];
        }else { //3> 其他 xx-xx xx:xx
            formatter.dateFormat = @"MM-dd HH:mm";
            return [formatter stringFromDate:date];
        }
    }else {//非今年
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        return [formatter stringFromDate:date];
    }
}

- (NSString *)source {
    NSUInteger start = [_source rangeOfString:@">"].location + 1;
    NSUInteger end = [_source rangeOfString:@"</"].location;
    NSRange subRange = NSMakeRange(start, end - start);
    return [NSString stringWithFormat:@"来自 %@", [_source substringWithRange:subRange]];
}

//判断是否为同一年
- (BOOL)isThisYearWithDate:(NSDate *)date now:(NSDate *)now{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitYear fromDate:date];
    NSDateComponents *nowComponents = [calendar components:NSCalendarUnitYear fromDate:now];
    return dateComponents.year == nowComponents.year;
}

//判断是否是昨天
- (BOOL)isYesterdayWithDate:(NSDate *)date now:(NSDate *)now {//需要去掉时分秒的计算干扰
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *nowStr = [formatter stringFromDate:now];
    date = [formatter dateFromString:dateStr];
    now = [formatter dateFromString:nowStr];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:calendarUnit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day ==1;
    
}

//判断是否是今天
- (BOOL)isTodayWithDate:(NSDate *)date now:(NSDate *)now {//需要去掉时分秒的计算干扰,也可以用字符串相同判断
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *nowStr = [formatter stringFromDate:now];
    date = [formatter dateFromString:dateStr];
    now = [formatter dateFromString:nowStr];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *dateComponents = [calendar components:calendarUnit fromDate:date];
    NSDateComponents *nowComponents = [calendar components:calendarUnit fromDate:now];
    return dateComponents.year == nowComponents.year && dateComponents.month == nowComponents.month && nowComponents.day == dateComponents.day;
}

//
- (NSDateComponents *)compareWithDate:(NSDate *)date now:(NSDate *)now {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit calendarUnit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute |NSCalendarUnitSecond;
    return [calendar components:calendarUnit fromDate:date toDate:now options:0];

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
