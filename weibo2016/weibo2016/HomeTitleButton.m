//
//  HomeTitleButton.m
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "HomeTitleButton.h"

@implementation HomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setTitle:@"首页" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font =[UIFont systemFontOfSize:17.0];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    return  self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, 70, 30);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
}
@end
