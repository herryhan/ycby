//
//  supportCountTableViewCell.m
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/21.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "supportCountTableViewCell.h"

@implementation supportCountTableViewCell
{
    UILabel *_countLabel;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *countLabel = [UILabel new];
        countLabel.textColor = [UIColor lightGrayColor];
        countLabel.font = [UIFont systemFontOfSize:15];
        _countLabel = countLabel;
        [self.contentView sd_addSubviews:@[countLabel]];
        _countLabel.sd_layout
        .leftSpaceToView(self.contentView, 15)
        .topSpaceToView(self.contentView, 10)
        .heightIs(20)
        .rightSpaceToView(self.contentView, 20);
        
         [self setupAutoHeightWithBottomView:_countLabel bottomMargin:10];
    }
    return self;
    
}

-(void)setCountString:(NSString *)countString
{

    _countString = countString;
    
    _countLabel.text = countString;
    
    NSMutableAttributedString *countStr = [[NSMutableAttributedString alloc]initWithString:countString];
    [countStr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(202, 44, 51,1) range:NSMakeRange(3, countString.length-6)];
    _countLabel.attributedText = countStr;
    
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
