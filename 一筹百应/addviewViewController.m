//
//  addviewViewController.m
//  一筹百应
//
//  Created by 韩先炜 on 2017/12/18.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "addviewViewController.h"
#import "addView.h"
#import "helpNewViewController.h"

@interface addviewViewController ()
@property (nonatomic,strong)UIScrollView *scrller;
@property (nonatomic,strong)addView *addFirstView;
@end

@implementation addviewViewController

- (addView *)addFirstView{
    declareWeakSelf;
    if (!_addFirstView) {
        _addFirstView = [[addView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)];
        [_addFirstView setSelectHelpType:^(NSInteger index) {
            if (index == 101) {
                helpNewViewController *helpVC= [[helpNewViewController alloc]init];
                helpVC.helpTitle = @"新增救助";
                [weakSelf.navigationController pushViewController:helpVC animated:YES];
            }
        }];
    }
    return _addFirstView;
}
- (UIScrollView *)scrller{
    if (!_scrller) {
        _scrller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
        _scrller.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _scrller.backgroundColor = [UIColor clearColor];
    }
    return _scrller;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"一筹百应"];
    [self.scrller addSubview:self.addFirstView];
    [self.view addSubview:self.scrller];
    
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
