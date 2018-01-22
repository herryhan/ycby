//
//  addHelpView.m
//  一筹百应
//
//  Created by 韩先炜 on 2017/12/29.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "addHelpView.h"

@implementation addHelpView 

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"addHelpView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    
    return self;
}

- (void)uiconfig{
    self.targetMoneyLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
    self.topicLabel.textColor =UIColorFromRGBA(202,44, 51, 1);
    self.desLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
    self.imageLabel.textColor = UIColorFromRGBA(202,44, 51, 1);
    self.phoneLabel.textColor= UIColorFromRGBA(202,44, 51, 1);
    self.targetMoneyText.backgroundColor = [UIColor whiteColor];
    
    self.targetMoneyText.delegate = self;
    self.topicText.delegate = self;
    self.desContentTextView.delegate = self;
    self.phoneText.delegate = self;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    for (int i = 1; i<4; i++) {
        UITextField *text = [self viewWithTag:200+i];
        [text resignFirstResponder];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.descText.hidden = YES;
    NSLog(@"dddddd");
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{

}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.descText.hidden = NO;
    }
}
- (void)textViewDidChange:(UITextView *)textView{
    self.countLabel.text = [NSString stringWithFormat:@"%ld/5000",textView.text.length];
}
@end
