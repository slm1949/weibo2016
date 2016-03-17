//
//  HomeTitleButton.m
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "HomeTitleButton.h"
#import "LMWeiboAccountTool.h"

@implementation HomeTitleButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setTitleTxt];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font =[UIFont systemFontOfSize:17.0];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    return  self;
}

- (void)setTitleTxt {
    LMWeiboAccount *weiboAccount = [LMWeiboAccountTool weiboAccount];
    [self setTitle:weiboAccount.name?weiboAccount.name:@"首页" forState:UIControlStateNormal];

    NSString *URLStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",weiboAccount.access_token,weiboAccount.uid];
    NSURL *URL = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *weiboAccountdict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"user--%@",weiboAccountdict);
            if (![weiboAccount.name isEqualToString:weiboAccountdict[@"name"]]) {
                weiboAccount.name = weiboAccountdict[@"name"];
                [LMWeiboAccountTool saveAccount:weiboAccount];
                [self setTitle:weiboAccount.name forState:UIControlStateNormal];
            }
            
        }
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    self.backgroundColor = [UIColor blueColor];
//    self.titleLabel.backgroundColor = [UIColor redColor];
//    self.imageView.backgroundColor = [UIColor yellowColor];
    
    //因为layoutsubviews不知什么原因会被调用两次，造成下面计算错误，所以加入if的判断，使得坐标调整只计算一次
    if (self.titleLabel.frame.origin.x > self.imageView.frame.origin.x) {
        //先移动title的x到image的x位置
        self.titleLabel.frame = CGRectMake(self.imageView.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
        //再移动image的x到title的最右边
        self.imageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), self.imageView.frame.origin.y, self.imageView.frame.size.width, self.imageView.frame.size.height);
    }
    
//    NSLog(@"title-%@",NSStringFromCGRect(self.titleLabel.frame));
//    NSLog(@"image-%@",NSStringFromCGRect(self.imageView.frame));
}
@end
