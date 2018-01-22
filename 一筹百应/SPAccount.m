//
//  SPAccount.m
//  ZTMall
//
//  Created by 庄园 on 17/1/22.
//  Copyright © 2017年 ztsm. All rights reserved.
//

#import "SPAccount.h"

@implementation SPAccount

+(instancetype)accountWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
    
}
-(instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [self init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"md5pwd"]) {
        return;
    }
}
/**
 *  从文件中解析对象时调用
 *
 */
//
//@property(nonatomic,assign) int64_t sex;
//@property(nonatomic,copy) NSString *headimg_url;
//@property(nonatomic,copy) NSString *nickname;
//@property(nonatomic,copy) NSString *unionid;
//@property(nonatomic,copy) NSString *openid;
//@property(nonatomic,copy) NSString *token;
//@property(nonatomic,copy) NSString *limit_date;

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.sex = [decoder decodeInt64ForKey:@"sex"];
        self.headimg_url = [decoder decodeObjectForKey:@"headimg_url"];
        
        //self.id = [decoder decodeInt64ForKey:@"id"];
        self.nickname = [decoder decodeObjectForKey:@"nickname"];
      //  self.lastLoginTime = [decoder decodeInt64ForKey:@"lastLoginTime"];
       
        self.unionid = [decoder decodeObjectForKey:@"unionid"];
        self.openid = [decoder decodeObjectForKey:@"openid"];
        self.token = [decoder decodeObjectForKey:@"token"];
        self.limit_date = [decoder decodeObjectForKey:@"limit_date"];
        
       
    }
    return self;
}
/**
 *  将对象写入文件时调用
 *
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {

    [aCoder encodeInt64:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.headimg_url forKey:@"headimg_url"];
    [aCoder encodeObject:self.nickname forKey:@"nickname"];
    [aCoder encodeObject:self.unionid forKey:@"unionid"];
    [aCoder encodeObject:self.openid forKey:@"openid"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.limit_date forKey:@"limit_date"];
    
}
@end

