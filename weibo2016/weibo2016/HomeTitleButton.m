//
//  HomeTitleButton.m
//  weibo2016
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "HomeTitleButton.h"
#import "LMweiboUser.h"

#define LMWeiboUserPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"weiboUser.archive"]

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
    LMweiboUser *weiboUser = [NSKeyedUnarchiver unarchiveObjectWithFile:LMWeiboUserPath];
    [self setTitle:weiboUser.name?weiboUser.name:@"首页" forState:UIControlStateNormal];

    NSString *URLStr = [NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",weiboUser.access_token,weiboUser.uid];
    NSURL *URL = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *weiboUserdict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //            NSLog(@"user--%@",weiboUserdict);
            if (![weiboUser.name isEqualToString:weiboUserdict[@"name"]]) {
                weiboUser.name = weiboUserdict[@"name"];
                [NSKeyedArchiver archiveRootObject:weiboUser toFile:LMWeiboUserPath];
                [self setTitle:weiboUser.name forState:UIControlStateNormal];
            }
            
        }
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bounds = CGRectMake(0, 0, 70, 30);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
}
@end
