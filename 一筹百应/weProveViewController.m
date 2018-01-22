//
//  weProveViewController.m
//  一筹百应
//
//  Created by 韩先炜 on 2018/1/20.
//  Copyright © 2018年 择善基金. All rights reserved.
//

#import "weProveViewController.h"
#import "CDZPicker.h"
#import "projectTypeModel.h"

@interface weProveViewController ()

@property (nonatomic,strong)NSMutableArray *contactArray;
@property (nonatomic,strong)NSNumber *typeNum;

@end

@implementation weProveViewController

- (NSMutableArray *)contactArray{
    if (!_contactArray) {
        _contactArray = [[NSMutableArray alloc]init];
    }
    return _contactArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self contitle:@"为Ta证实"];
    [self uiconfig];
    
    [self getProveTypeRequest];
    
}

- (void)getProveTypeRequest{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"token"] = [SPAccountTool account].token;
    parmas[@"project_type"] = @(4);
    [ycbyHttpRequest postWithURL:@"/service/user/get_project_type/" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",jsonDict);
        if ([jsonDict[@"info"] count]!=0) {
            [self.contactArray addObjectsFromArray:[NSArray yy_modelArrayWithClass:[projectTypeModel class] json:jsonDict[@"info"][@"project_type"]]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)uiconfig{
    
    self.submitBtn.backgroundColor = UIColorFromRGBA(202, 44, 51, 1);
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.layer.masksToBounds = YES;
    self.contactBgView.layer.borderWidth = 0.5;
    self.contactBgView.layer.borderColor = UIColorFromRGBA(240, 240, 240, 1).CGColor;
    self.detailBgView.layer.borderWidth = 0.5;
    self.detailBgView.layer.borderColor = UIColorFromRGBA(240, 240, 240, 1).CGColor;
    
}
- (IBAction)submitPress:(UIButton *)sender{
    
    [self.cotactText resignFirstResponder];
    NSLog(@"%@",self.typeNum);
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"token"] = [SPAccountTool account].token;
    parmas[@"prove_type"] = self.typeNum;
    parmas[@"project_id"] = self.projectId;
    parmas[@"content"] = self.detailConditionText.text;
    [ycbyHttpRequest postWithURL:@"/service/user/add_project_prove/" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.detailConditionText resignFirstResponder];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectContactTypePres:(UIButton *)sender {
    
    [self.detailConditionText resignFirstResponder];
    CDZPickerBuilder *builder = [[CDZPickerBuilder alloc]init];
    builder.confirmTextColor = UIColorFromRGBA(202, 44, 51, 1);
    builder.cancelTextColor = UIColorFromRGBA(202, 44, 51, 1);
    // builder.pickerTextColor = UIColorFromRGBA(68, 195, 34, 1);
    NSMutableArray *typeArray = [[NSMutableArray alloc]init];
    for (projectTypeModel *model in self.contactArray) {
        [typeArray addObject:model.project_type_name];
    }
    [CDZPicker showMultiPickerInView:self.view withBuilder:builder stringArrays:@[typeArray] confirm:^(NSArray<NSString *> * _Nonnull strings, NSArray<NSNumber *> * _Nonnull indexs) {
        self.cotactText.text = strings[0];
        int i = [indexs[0] intValue];
        
        projectTypeModel *model = self.contactArray[i];
        self.typeNum = model.id;
        
    } cancel:^{
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
