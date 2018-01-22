//
//  supportModel.h
//  一筹百应
//
//  Created by 庄园 on 17/10/20.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface supportModel : NSObject

@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *headimg_url;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSNumber *support_money;
@property (nonatomic,copy) NSString *create_date;
@property (nonatomic,copy) NSNumber *is_anonymous;

//nickname : 用户昵称
//headimg_url : 用户头像
//content : 支持内容
//support_money : 支持金额(单位:元)
//create_date : 支持时间
//is_anonymous:是否匿名 0、否，1、是

@end
