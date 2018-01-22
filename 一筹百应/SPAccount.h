//
//  SPAccount.h
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAccount : NSObject <NSCoding>

@property(nonatomic,assign) int64_t sex;
@property(nonatomic,copy) NSString *headimg_url;
@property(nonatomic,copy) NSString *nickname;
@property(nonatomic,copy) NSString *unionid;
@property(nonatomic,copy) NSString *openid;
@property(nonatomic,copy) NSString *token;
@property(nonatomic,copy) NSString *limit_date;


+ (instancetype)accountWithDict:(NSDictionary *)dict;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

