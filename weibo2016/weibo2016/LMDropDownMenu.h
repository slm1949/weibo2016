//
//  LMDropDownMenu.h
//  weibo2016
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DropDownMenudelegate <NSObject>

- (void)dismissMenu;

@end

@interface LMDropDownMenu : UIView

@property (nonatomic, strong) UIView *content;
@property (nonatomic, strong) UIViewController *contentController;
@property (nonatomic, strong) id<DropDownMenudelegate>delegate;

- (void)dropDownMenuForView:(UIView *)view;

@end
