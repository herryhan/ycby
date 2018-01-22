//
//  proveTableViewCell.m
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/18.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "proveTableViewCell.h"

@implementation proveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 25;
    self.headImageView.layer.masksToBounds = YES;
}
- (void)setModel:(proveModel *)model{
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimg_url]];
    self.nickNameText.text = model.nickname;
    self.proveContent.text = model.content;
    self.proveTypeText.text = model.prove_type_name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
