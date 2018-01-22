//
//  homeModel.h
//  一筹百应
//
//  Created by 庄园 on 17/10/15.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeModel : NSObject


@property (nonatomic,copy) NSString *headimg_url;
@property (nonatomic,copy) NSString *help_count;
@property (nonatomic,copy) NSArray *img;
@property (nonatomic,copy) NSString *project_id;
@property (nonatomic,copy) NSString *project_name;
@property (nonatomic,copy) NSNumber *prove_num;
@property (nonatomic,copy) NSNumber *ready_money;
@property (nonatomic,copy) NSNumber *targe_money;
@property (nonatomic,copy) NSString *nickname;

@end
