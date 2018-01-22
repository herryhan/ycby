//
//  projectDetailBottomView.h
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/12.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "project_basicModel.h"

@interface projectDetailBottomView : UIView

@property (weak, nonatomic) IBOutlet UIButton *obseverBtn;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (nonatomic,strong)void (^collectionBtnPress)(void);
@property (nonatomic,strong)void (^linkerBtnPress)(void);

@property (nonatomic,strong) project_basicModel *model;

@end
