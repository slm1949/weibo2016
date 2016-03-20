//
//  LMStatusCell.m
//  weibo2016
//
//  Created by mac on 16/3/19.
//  Copyright © 2016年 songlm. All rights reserved.
//

#import "LMStatusCell.h"
#import "UIImageView+WebCache.h"

@interface LMStatusCell()

/**微博信息的发布者头像 */
@property (nonatomic, weak) UIImageView *profileImageView;

/**微博信息的发布者昵称 */
@property (nonatomic, weak) UILabel *nameLabel;

/**微博会员 */
@property (nonatomic, weak) UIImageView *vipImageView;

@end

@implementation LMStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    NSString *ID = @"weibo";
    //先从缓冲池中取
    LMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //如果没有就创建
    if (!cell) {
        cell = [[LMStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//传入模型StatusCellFrame时，给相关控件属性及其frame赋值(重写set方法)
- (void)setStatusCellFrame:(LMStatusFrame *)StatusCellFrame {
    _StatusCellFrame = StatusCellFrame;//固定写法，先给自己的属性赋值
    
    UIImageView *profileImageView = [[UIImageView alloc] init];
    NSURL *url = [NSURL URLWithString:self.StatusCellFrame.status.user.profile_image_url];
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default"];
    [profileImageView sd_setImageWithURL:url placeholderImage:placeholder];
    profileImageView.frame = self.StatusCellFrame.profileImageViewFrame;
//    NSLog(@"%@",profileImageView);
    [self addSubview:profileImageView];
}

@end
