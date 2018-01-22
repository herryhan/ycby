//
//  ycbyHttpRequest.h
//  一筹百应
//
//  Created by 庄园 on 17/10/9.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface ycbyHttpRequest : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  @brief  发送一个POST请求(上传文件数据)
 *
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param success  请求成功后的回调
 *  @param failure  请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 *  发送一个POST请求(上传文件数据)
 *
 *  @param url           请求路径
 *  @param params        请求参数
 *  @param formDataArray 文件参数
 *  @param success       请求成功后的回调
 *  @param failure       请求失败后的回调
 */
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray name:(NSString *)name success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
