//
//  YBLoginViewController.m
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/23.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "YBLoginViewController.h"

@interface YBLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPwdBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *codeText;

@end

@implementation YBLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiconfig];
}

- (void)uiconfig{
    
    self.loginBtn.layer.cornerRadius = 20;
    self.loginBtn.layer.masksToBounds = YES;
    self.loginBtn.backgroundColor = UIColorFromRGBA(202, 44, 51, 1);
    self.registerBtn.layer.cornerRadius = 20;
    self.registerBtn.layer.masksToBounds = YES;
    self.registerBtn.layer.borderWidth = 0.5;
    self.registerBtn.layer.borderColor = UIColorFromRGBA(202, 44, 51, 1).CGColor;
    [self.registerBtn setTitleColor:UIColorFromRGBA(202, 44, 51, 1) forState:UIControlStateNormal];
    [self.forgetPwdBtn setTitleColor:UIColorFromRGBA(202, 44, 51, 1) forState:UIControlStateNormal];
    self.timeBtn.layer.cornerRadius = 2;

    [self.timeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.timeBtn setTitleColor:UIColorFromRGBA(202, 44, 51, 1) forState:UIControlStateNormal];
    
}
- (IBAction)timeBtnPress:(UIButton *)sender {
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.timeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                [self.timeBtn setTitleColor:UIColorFromRGBA(202, 44, 51, 1) forState:UIControlStateNormal];
                self.timeBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.timeBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.timeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                self.timeBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneText resignFirstResponder];
    [self.codeText resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
