//
//  homeTableViewCell.m
//  一筹百应
//
//  Created by 庄园 on 17/10/15.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "homeTableViewCell.h"

@implementation homeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)cellConfigWithModel:(homeModel *)model{

    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headimg_url]];
    self.headImageView.layer.cornerRadius = 12.5;
    self.headImageView.layer.masksToBounds =YES;
    
    self.nickNameLabel.text = model.nickname;
   // self.proveNumLabel.text = [NSString stringWithFormat:@"%@人证实",model.prove_num];
    self.constructLabel.text =model.project_name;
    self.imageScroller.contentSize = CGSizeMake(105*model.img.count, 100);
    self.lineView.backgroundColor = UIColorFromRGBA(233, 233, 233, 1);
    
    for (int i=0; i<model.img.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0+100*i+5*i, 0, 100, 100)];
        image.contentMode = UIViewContentModeScaleAspectFill;
        image.clipsToBounds = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:model.img[i][@"img_url"]]];
        [self.imageScroller addSubview:image];
    }
   // self.imageScroller.gestureRecognizers =self;
    UITapGestureRecognizer *panRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hh)];
    [self.imageScroller addGestureRecognizer:panRecognizer];//关键语句，给self.view添加一个手势监测；
    //panRecognizer.maximumNumberOfTouches = 1;
    panRecognizer.delegate = self;
    
    self.progressView.progress = [model.ready_money floatValue]/[model.targe_money floatValue];
    self.progressView.trackTintColor = UIColorFromRGBA(233, 233, 233, 1);
    self.progressView.progressTintColor = [UIColor redColor];
    self.percetLabel.text = [NSString stringWithFormat:@"%0.2f％",[model.ready_money floatValue]/[model.targe_money floatValue]*100 ];
    
    //更改颜色
    NSMutableAttributedString *proString =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@人证实",model.prove_num]];
     [proString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(2024, 44, 51, 1) range:NSMakeRange(0, proString.length-3)];
    self.proveNumLabel.attributedText = proString;
    
    NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"目标%@元",model.targe_money]];
    [targetString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(85, 85, 85,1) range:NSMakeRange(2, targetString.length-3)];
    self.targetLabel.attributedText = targetString;
    
    NSMutableAttributedString *getString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"已筹%@元",model.ready_money]];
    [getString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(85, 85, 85,1) range:NSMakeRange(2, getString.length-3)];
    self.getLabel.attributedText = getString;
    
    NSMutableAttributedString *supportString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@次支持",model.help_count]];
    [supportString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(85, 85, 85,1) range:NSMakeRange(0, supportString.length-3)];
    self.supportLabel.attributedText = supportString;
    
}
-(void)hh{

    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch

{
    
    // 输出点击的view的类名
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        
        return NO;
        
    }
    
    return YES;
    
}


@end
