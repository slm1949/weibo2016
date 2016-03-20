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
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

//相关控件的创建应该放在初始化的时候
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UIImageView *profileImageView = [[UIImageView alloc] init];
    [self addSubview:profileImageView];
    self.profileImageView = profileImageView;
    
    return self;
}

//传入模型StatusCellFrame时，给相关控件属性及其frame赋值(重写set方法),添加相关控件不能再里面这样就以为着，每重用一次，就会被创建一次，这样的错误的。
- (void)setStatusFrame:(LMStatusFrame *)statusFrame {
    _statusFrame = statusFrame;//固定写法，先给自己的属性赋值
    
    NSURL *url = [NSURL URLWithString:self.statusFrame.status.user.profile_image_url];
    UIImage *placeholder = [UIImage imageNamed:@"avatar_default"];
    [self.profileImageView sd_setImageWithURL:url placeholderImage:placeholder];
    self.profileImageView.frame = self.statusFrame.profileImageViewFrame;


}

@end
