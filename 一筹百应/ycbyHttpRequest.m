//
//  ycbyHttpRequest.m
//  一筹百应
//
//  Created by 庄园 on 17/10/9.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "ycbyHttpRequest.h"

@implementation ycbyHttpRequest

//#define BASEURL @"https://ycby-dev.zezhu.org/service"
#define BASEURL @"https://ycby.zezhu.org/service"
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
            NSLog(@"%@",error);
        }
    }];
}


+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    
    NSLog(@"parma:%@",params);
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
   mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    
    // 加上这行代码，https ssl 验证。
    if(YES) {
        [mgr setSecurityPolicy:[self customSecurityPolicy]];
    }

     mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   
    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
        // [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }
    
    }];
    
}

//上传图片、音频、视频文件
+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params formDataArray:(NSArray *)formDataArray name:(NSString *)name success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.创建请求管理对象
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",nil];
    // AFHTTPResponseSerializer
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (id object in formDataArray) {
            if ([[object class] isSubclassOfClass:[UIImage class]]) {
                NSData *data = UIImageJPEGRepresentation(object, 2);
                [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"%@.png",name] mimeType:@"image/png"];
                
            }else if ([[object class] isSubclassOfClass:[NSURL class]]){
                
                NSLog(@"%@",object);
                [formData appendPartWithFileURL:object name:@"video" fileName:[NSString stringWithFormat:@"%@.mp3",name] mimeType:@"application/octet-stream" error:nil];
                
            }else if ([[object class] isSubclassOfClass:[NSString class]]){
                
                NSLog(@"if test success!");
                [formData appendPartWithFileURL:[NSURL fileURLWithPath:object] name:@"mp4" fileName:[NSString stringWithFormat:@"%@.mp4",name] mimeType:@"video/mp4" error:nil];
                
            }
            
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }
    }];
    
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"appcert" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    //AFSSLPinningModeNone: 代表客户端无条件地信任服务器端返回的证书。
    //AFSSLPinningModePublicKey: 代表客户端会将服务器端返回的证书与本地保存的证书中，PublicKey的部分进行校验；如果正确，才继续进行。
    //AFSSLPinningModeCertificate: 代表客户端会将服务器端返回的证书和本地保存的证书中的所有内容，包括PublicKey和证书部分，全部进行校验；如果正确，才继续进行。
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    //对应域名的校验我认为应该在url中去逻辑判断。--》冯龙腾写
    securityPolicy.validatesDomainName = NO;
    if (certData) {
        securityPolicy.pinnedCertificates = @[certData];
    }
    
    
    return securityPolicy;
}


@end
