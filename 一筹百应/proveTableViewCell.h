//
//  proveTableViewCell.h
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/18.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "proveModel.h"

@interface proveTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameText;
@property (weak, nonatomic) IBOutlet UILabel *proveContent;
@property (weak, nonatomic) IBOutlet UILabel *proveTypeText;
@property (nonatomic,strong) proveModel *model;

@end
