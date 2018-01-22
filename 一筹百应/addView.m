//
//  addView.m
//  一筹百应
//
//  Created by 韩先炜 on 2017/12/18.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "addView.h"

@implementation addView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"addView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            NSLog(@"ffff%@",arrayObjectViews);
            for (id obj in arrayObjectViews) {
                self = obj;
                NSLog(@"subview:%@",[obj subviews]);
                self.frame = frame;
                self.backgroundColor = [UIColor clearColor];
                //[self uiconfig];
            }
        }
    }
    
    return self;
}
- (IBAction)addHelpPress:(UIButton *)sender {
    NSLog(@"help");
    _selectHelpType(sender.tag);
}
- (IBAction)addDreamPress:(UIButton *)sender {
    NSLog(@"dream");
    _selectHelpType(sender.tag);
}

@end
