//
//  LMItemTool.h
//  weibo2016
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LMItemTool : UIView

+ (UIBarButtonItem *)itemToolAddTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage;

@end
