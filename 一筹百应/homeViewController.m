//
//  homeViewController.m
//  一筹百应
//
//  Created by 庄园 on 17/10/8.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "homeViewController.h"
#import "helpViewController.h"
#import "dreamViewController.h"
#import "projectViewController.h"
#import "hxwSegmentView.h"


@interface homeViewController ()



@end

#define headerViewHeight 170

@implementation homeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"一筹百应"];
    helpViewController *rvc = [[helpViewController alloc] init];
    dreamViewController *cvc = [[dreamViewController alloc] init];
    projectViewController *gvc = [[projectViewController alloc] init];
    
    NSArray *controllers = @[rvc,gvc,cvc];
    NSArray *titleArray = @[@"公益求助", @"公益项目",@"众筹梦想"];
    
    hxwSegmentView *hss = [[hxwSegmentView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) buttonName:titleArray contrllers:controllers parentController:self];
    
    [self.view addSubview:hss];

    // Do any additional setup after loading the view.
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
