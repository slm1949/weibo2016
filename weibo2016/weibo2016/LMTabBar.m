//
//  LMtabBar.m
//  weibo2016
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMtabBar.h"

@implementation LMTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addPlusButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    Class class = NSClassFromString(@"UITabBarButton");
    CGFloat tabBarButtonW = self.frame.size.width / 5;
    NSInteger tabBarButtonIndex = 0;
    for (UIView *subview in self.subviews) {
        
        if ([subview isKindOfClass:class]) {
            subview.frame = CGRectMake(tabBarButtonW * tabBarButtonIndex, subview.frame.origin.y, tabBarButtonW, subview.frame.size.height);
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }else if ([subview isKindOfClass:[UIButton class]]) {
            subview.center = CGPointMake(self.bounds.size.width *0.5, self.bounds.size.height *0.5);
        }
    }
    
}

- (void)addPlusButton {
    UIButton *plusButton = [[UIButton alloc] init];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    plusButton.bounds = CGRectMake(0, 0, 64, 44);
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:plusButton];
}

- (void)plusClick {
    
}

@end
