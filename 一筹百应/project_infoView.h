//
//  project_infoView.h
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/23.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "project_basicModel.h"
typedef void (^Returnheight) (double returnValue);

@interface project_infoView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectTopicLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *gotMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *helpCountLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *percentProgress;
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *horLineview1;
@property (weak, nonatomic) IBOutlet UIView *horLineView2;
@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UILabel *patientNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sickNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *payeeNameLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailLabelConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *detailViewConstraint;

- (CGFloat)setValueWithDic:(project_basicModel *) publicModel;
@property (weak, nonatomic) IBOutlet UILabel *hospitalNameLabel;

@property (weak, nonatomic) IBOutlet UIView *proveLine1;
@property (weak, nonatomic) IBOutlet UIView *proveLine2;
@property (weak, nonatomic) IBOutlet UIView *proveLine3;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *promiseLabel;
@property (weak, nonatomic) IBOutlet UIView *promiseView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstProveStringLabel;

@property (weak, nonatomic) IBOutlet UIView *imageBgView;
@property (weak, nonatomic) IBOutlet UIView *proveView;
@property (weak, nonatomic) IBOutlet UIButton *proveBtn;

@property (nonatomic,strong) void(^proveBtnBlock)(void);
@property (nonatomic,strong) void(^showProveDetailBlock)(void);

@property (nonatomic,strong) void(^showPics)(NSArray *imagesUrlArray,NSInteger imageSelectedIndex,UIImageView *imageV);
@property (nonatomic,strong) project_basicModel *model;

@end
