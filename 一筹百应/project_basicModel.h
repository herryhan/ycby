//
//  project_basicModel.h
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/21.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface project_basicModel : NSObject

//项目详情
@property (nonatomic,copy) NSString *project_name;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *headimg_url;
@property (nonatomic,copy) NSNumber *targe_money;
@property (nonatomic,copy) NSString *ready_money;
@property (nonatomic,copy) NSNumber *help_count;
@property (nonatomic,copy) NSString *lauch_time;
@property (nonatomic,copy) NSString *limit_time;
@property (nonatomic,copy) NSString *project_detail;
@property (nonatomic,copy) NSArray *imgArray;
@property (nonatomic,copy) NSNumber *is_focus;


//病人详情
@property (nonatomic,copy) NSString *patient_name;
@property (nonatomic,copy) NSString *sick_name;
@property (nonatomic,copy) NSString *payee_name;
@property (nonatomic,copy) NSString *payee_type_name;
@property (nonatomic,copy) NSString *hospital_name;

//证明人信息
@property (nonatomic,copy) NSMutableArray *imageArray;
@property (nonatomic,copy) NSNumber *proveCountNum;
@property (nonatomic,copy) NSString *fisrtProveString;


@end
