//
//  homeTableViewCell.h
//  一筹百应
//
//  Created by 庄园 on 17/10/15.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYProGressView.h"
#import "homeModel.h"

@interface homeTableViewCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *proveNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *constructLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *imageScroller;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *percetLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetLabel;
@property (weak, nonatomic) IBOutlet UILabel *getLabel;
@property (weak, nonatomic) IBOutlet UILabel *supportLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


-(void)cellConfigWithModel:(homeModel *)model;

@end
