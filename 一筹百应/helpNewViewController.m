//
//  helpNewViewController.m
//  一筹百应
//
//  Created by 韩先炜 on 2017/12/29.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "helpNewViewController.h"
#import "addHelpView.h"

@interface helpNewViewController ()

@property (nonatomic,strong) UIScrollView *helpScroller;
@property (nonatomic,strong) addHelpView *helpView;
@property (nonatomic,strong) UIButton *submitBtn;

@end

@implementation helpNewViewController

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.frame =CGRectMake(0, SCREEN_HEIGHT-SafeAreaBottomHeight, SCREEN_WIDTH, SafeAreaBottomHeight);
        _submitBtn.backgroundColor = UIColorFromRGBA(202,44, 51, 1);
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(submitPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
- (void)submitPress{
    
}
- (UIScrollView *)helpScroller{
    if (!_helpScroller) {
        _helpScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH,SCREEN_HEIGHT-SafeAreaTopHeight-SafeAreaBottomHeight)];
        _helpScroller.contentSize = CGSizeMake(SCREEN_WIDTH, 728);
    }
    return _helpScroller;
}
- (addHelpView *)helpView{
    if (!_helpView) {
        _helpView = [[addHelpView alloc]initWithFrame:(CGRect)CGRectMake(0, 0, SCREEN_WIDTH, 728)];
    }
    return _helpView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:self.helpTitle];
    [self uiconfig];
}
- (void)uiconfig{
    [self.helpScroller addSubview:self.helpView];
    [self.view addSubview:self.helpScroller];
    [self.view addSubview:self.submitBtn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
