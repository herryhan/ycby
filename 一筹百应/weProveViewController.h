//
//  weProveViewController.h
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/20.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "baseViewController.h"

@interface weProveViewController : baseViewController

@property (weak, nonatomic) IBOutlet UIView *contactBgView;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIView *detailBgView;
@property (weak, nonatomic) IBOutlet UITextField *detailConditionText;
@property (weak, nonatomic) IBOutlet UITextField *cotactText;

@property (nonatomic,strong) NSString *projectId;

@end
