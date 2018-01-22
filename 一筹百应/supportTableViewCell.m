//
//  supportTableViewCell.m
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/20.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "supportTableViewCell.h"


#import <UIImageView+WebCache.h>

@implementation supportTableViewCell
{
    UIImageView *_headImageView;
    UILabel *_nickNameLable;
    UILabel *_supportContentLabel;
    UILabel *_supportMoneyLabel;
    UILabel *_supportTime;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpProperty];
    }
    return self;
}
-(void)setUpProperty{

    //头像
    UIImageView *headImageView = [UIImageView new];
    headImageView.layer.cornerRadius = 20;
    headImageView.layer.masksToBounds = YES;
    _headImageView = headImageView;
    
    //昵称
    UILabel *nickNameLable = [UILabel new];
    nickNameLable.font = [UIFont systemFontOfSize:15];
    _nickNameLable = nickNameLable;
    
    //支持内容
    UILabel *supportContentLabel = [UILabel new];
    supportContentLabel.font = [UIFont systemFontOfSize:14];
    supportContentLabel.textColor = [UIColor lightGrayColor];
    _supportContentLabel = supportContentLabel;
    
    //支持的时间
    UILabel *supportTime = [UILabel new];
    supportTime = [UILabel new];
    supportTime.textColor = [UIColor lightGrayColor];
    supportTime.textAlignment = NSTextAlignmentRight;
    supportTime.font = [UIFont systemFontOfSize:13];
    _supportTime = supportTime;
    
    //支持金额
    UILabel *supportMoneyLabel = [UILabel new];
    supportMoneyLabel.textAlignment = NSTextAlignmentRight;
    supportMoneyLabel.textColor = [UIColor lightGrayColor];
    supportMoneyLabel.font = [UIFont systemFontOfSize:13];
    _supportMoneyLabel = supportMoneyLabel;
    
    [self.contentView sd_addSubviews:@[headImageView,nickNameLable,supportMoneyLabel,supportTime,supportContentLabel]];
    
    /*配置约束*/
    //头像
    _headImageView.sd_layout.widthIs(40)
                            .heightIs(40)
                            .leftSpaceToView(self.contentView, 15)
                            .topSpaceToView(self.contentView, 15);
    //支持金额
    _supportMoneyLabel.sd_layout.rightSpaceToView(self.contentView, 15).heightIs(20).topSpaceToView(self.contentView, 15).widthIs(100);
    //支持时间
    _supportTime.sd_layout.topSpaceToView(self.contentView, 15).rightSpaceToView(_supportMoneyLabel, 5).heightIs(20).widthIs(100);
    
    //昵称
    _nickNameLable.sd_layout.leftSpaceToView(_headImageView, 8)
    .topSpaceToView(self.contentView, 15)
    .heightIs(20)
    .rightSpaceToView(_supportTime, 10);
    
    //支持内容
    _supportContentLabel.sd_layout.leftEqualToView(_nickNameLable)
    .heightIs(20)
    .rightSpaceToView(self.contentView, 15)
    .topSpaceToView(_nickNameLable, 0);
    
    
}

-(void)setModel:(supportModel *)model{

    _model = model;
    
    
    if ([model.is_anonymous intValue] ==1) {
        _nickNameLable.text = @"匿名";
        [_headImageView setImage:[UIImage imageNamed:@"user"]];
    }else{
    
        _nickNameLable.text = model.nickname;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimg_url]];
    }
    
    
    _supportMoneyLabel.text = [NSString stringWithFormat:@"支持了%@元",model.support_money];
    _supportMoneyLabel.sd_layout.widthIs([self rectSizeWithString:_supportMoneyLabel.text andFont:_supportMoneyLabel.font].size.width);
    
    _supportTime.text = model.create_date;
    _supportTime.sd_layout.widthIs([self rectSizeWithString:_supportTime.text andFont:_supportTime.font].size.width);
    
    _supportContentLabel.text = model.content;
    
    [self setupAutoHeightWithBottomView:_supportContentLabel bottomMargin:10];
    
}
-(CGRect)rectSizeWithString:(NSString *)string andFont:(UIFont *)font{

    return [string  boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-100, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
