//
//  projectDetailBottomView.m
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/12.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "projectDetailBottomView.h"

@implementation projectDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:@"projectDetailBottomView" owner:self options:nil];
        if (arrayOfViews.count<1) {
            return nil;
        }else{
            for (id obj in arrayOfViews) {
                if ([obj isKindOfClass:[projectDetailBottomView class]]){
                    self = obj;
                    self.frame = frame;
                    [self uiconfig];
                }
            }
        }
    }
    
    return self;
    
}
- (void)uiconfig{
    
    [self.payBtn setBackgroundColor:UIColorFromRGBA(202, 44, 51, 1)];
    self.payBtn.layer.cornerRadius = 5;
    self.payBtn.layer.masksToBounds = YES;
    
}
- (IBAction)collectionBtn:(UIButton *)sender {
    _collectionBtnPress();
}
- (IBAction)linkerBtn:(UIButton *)sender {
    _linkerBtnPress();
    
}
-(void)setModel:(project_basicModel *)model{
    _model = model;
    NSLog(@"gzccccc%@",model.project_name);
    if ([model.is_focus intValue] == 1 ) {
        [self.obseverBtn setImage:[UIImage imageNamed:@"icon_follow_fill"] forState:UIControlStateNormal];
    }else{
        [self.obseverBtn setImage:[UIImage imageNamed:@"icon_follow"] forState:UIControlStateNormal];
    }
}

@end
