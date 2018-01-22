//
//  project_basicViewModel.m
//  一筹百应
//
//  Created by 韩先伟 on 2017/10/21.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "project_basicViewModel.h"
#import "project_basicModel.h"
#import "detailProveModel.h"

@implementation project_basicViewModel


-(void)fetchBasicInfo:(NSString *)pro_id andToken:(NSString *)token{

  
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    project_basicModel *model = [[project_basicModel alloc]init];
    
    //项目支持
    NSMutableDictionary *parama = [[NSMutableDictionary alloc]init];
    parama[@"token"]= token;
    parama[@"project_id"] = pro_id;
    //项目申请人情况
    NSMutableDictionary *parama1 = [[NSMutableDictionary alloc]init];
    parama1[@"project_id"] = pro_id;
    //项目证实情况
    NSMutableDictionary *parama2 =[[NSMutableDictionary alloc]init];
    parama2[@"project_id"] = pro_id;
    parama2[@"page"] = @(1);
    parama2[@"page_num"] = @(10);
    
    NSString *urlStr1 = @"/service/project/project_detail/";
    NSString *urlStr2 = @"/service/project/get_project_detail_prove/";
    NSString *urlStr3 = @"/service/project/project_prove/";
    
    NSArray *urlStrings = @[urlStr1, urlStr2,urlStr3];
    NSArray *params = @[parama,parama1,parama2];
    
    dispatch_group_t requestGroup = dispatch_group_create();
  
    for(int i = 0;i<3;i++) {
        dispatch_group_enter(requestGroup);
       
        [ycbyHttpRequest postWithURL:urlStrings[i] params:params[i] success:^(NSURLSessionDataTask *task, id responseObject) {
            NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if (i == 0) {
                
                model.project_name = jsonDict[@"info"][@"project"][@"project_name"];
                model.nickname = jsonDict[@"info"][@"project"][@"nickname"];
                model.headimg_url = jsonDict[@"info"][@"project"][@"headimg_url"];
                model.targe_money = jsonDict[@"info"][@"project"][@"targe_money"];
                model.ready_money = jsonDict[@"info"][@"project"][@"ready_money"];
                model.help_count = jsonDict[@"info"][@"project"][@"help_count"];
                model.lauch_time = jsonDict[@"info"][@"project"][@"lauch_time"];
                model.limit_time = jsonDict[@"info"][@"project"][@"limit_time"];
                model.project_detail = jsonDict[@"info"][@"project"][@"project_detail"];
                model.imgArray = jsonDict[@"info"][@"img"];
                model.is_focus = jsonDict[@"info"][@"project"][@"is_focus"];
                
            }else if(i == 1) {
            
                model.hospital_name = jsonDict[@"info"][@"diagnose"][@"hospital_name"];
                model.sick_name = jsonDict[@"info"][@"diagnose"][@"sick_name"];
                model.patient_name = jsonDict[@"info"][@"patient"][@"patient_name"];
                model.payee_name = jsonDict[@"info"][@"payee"][@"payee_name"];
                model.payee_type_name = jsonDict[@"info"][@"payee"][@"payee_type_name"];
                
            }else{
                
                model.imageArray = jsonDict[@"info"][@"prove"];
                model.proveCountNum = jsonDict[@"info"][@"count_num"];
                model.fisrtProveString = jsonDict[@"info"][@"prove"][0][@"content"];
            }
           
            NSLog(@"pp: %@",jsonDict);
            
            dispatch_group_leave(requestGroup);
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
             dispatch_group_leave(requestGroup);
            
        }];
    }
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        
        [arr addObject:model];
         self.returnBlock(arr);
        
    });
    
    
}
/**
 对ErrorCode进行处理
 
 @param errorDic
 */
-(void) errorCodeWithDic: (NSDictionary *) errorDic {
    self.errorBlock(errorDic);
}


@end
