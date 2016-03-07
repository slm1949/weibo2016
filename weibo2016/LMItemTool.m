//
//  LMItemTool.m
//  weibo2016
//
//  Created by mac on 16/3/7.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMItemTool.h"

@implementation LMItemTool

+ (UIBarButtonItem *)itemToolAddTarget:(id)target action:(SEL)action image:(NSString *)image highlightedImage:(NSString *)highlightedImage {
    
    UIImage *Img = [UIImage imageNamed:image];
    UIButton *Button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Img.size.width, Img.size.height)];
    [Button setImage:Img forState:UIControlStateNormal];
    [Button setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:Button];
    
}
    



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
