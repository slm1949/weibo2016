//
//  NSString+Extension.m
//  weibo2016
//
//  Created by mac on 16/3/20.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSMutableDictionary *attrs = [[NSMutableDictionary alloc] init];
    attrs[NSFontAttributeName] = font;
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end