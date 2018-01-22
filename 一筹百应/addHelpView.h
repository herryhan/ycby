//
//  addHelpView.h
//  一筹百应
//
//  Created by 韩先炜 on 2017/12/29.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface addHelpView : UIView <UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *targetMoneyLabel;
@property (weak, nonatomic) IBOutlet UITextField *targetMoneyText;
@property (weak, nonatomic) IBOutlet UILabel *topicLabel;
@property (weak, nonatomic) IBOutlet UITextField *topicText;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *descText;
@property (weak, nonatomic) IBOutlet UITextView *desContentTextView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollection;
@property (weak, nonatomic) IBOutlet UILabel *imageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *constratBtn;
@property (weak, nonatomic) IBOutlet UIButton *promiseBookBtn;

@end
