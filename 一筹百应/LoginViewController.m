//
//  LoginViewController.m
//  一筹百应
//
//  Created by 庄园 on 17/10/9.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "LoginViewController.h"

#import "ycbyHttpRequest.h"

@interface LoginViewController ()<WXApiDelegate>


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /**获取**/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLogin:) name:@"WXLoginSuccess" object:nil];
    
    [self uiconfig];
    // Do any additional setup after loading the view from its nib.
}
- (void)uiconfig{
    
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-100, 100, 100)];
    [self.iconImageView setImage:[UIImage imageNamed:@"icon"]];
    [self.view addSubview:self.iconImageView];
    self.view.backgroundColor = UIColorFromRGBA(255, 23, 0, 1);
    
    //设置登录按钮
    self.LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LoginBtn.frame = CGRectMake(SCREEN_WIDTH/2-50, self.iconImageView.frame.origin.y+self.iconImageView.frame.size.height+20, 100, 30);
    [self.LoginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
    [self.LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.LoginBtn.layer.cornerRadius = 15;
    self.LoginBtn.layer.borderWidth = 1.0;
    self.LoginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.LoginBtn addTarget:self action:@selector(LoginPress) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.LoginBtn];
    
}

- (void)WXLogin:(NSNotification *)noti{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD showWithStatus:@"登陆中"];
    declareWeakSelf;
    [ycbyHttpRequest getWithURL:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",@"wx4dc3912fdae00437",@"72a72040ecdaeb66a4ad156f5373073b",noti.object[@"code"]] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *wxDict = [NSDictionary dictionaryWithDictionary:[self jsonConvertDic:responseObject]];
        [ycbyHttpRequest getWithURL:[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",wxDict[@"access_token"],wxDict[@"openid"]] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
            NSDictionary *wxprarms =[NSDictionary dictionaryWithDictionary:[self jsonConvertDic:responseObject]];
            /******微信登陆参数******/
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            parmas[@"unionid"] = wxprarms[@"unionid"];
            parmas[@"sex"] = wxprarms[@"sex"];
            parmas[@"nickname"] =wxprarms[@"nickname"];
            parmas[@"headimg_url"] = wxprarms[@"headimgurl"];
            parmas[@"openid"] = wxprarms[@"openid"];
            
            [ycbyHttpRequest postWithURL:@"/service/project/app_login/" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"微信登录反回的结果：%@",responseObject);
                [SVProgressHUD dismissWithCompletion:^{
                    NSLog(@"denglu :%@",[weakSelf jsonConvertDic:responseObject]);
                    
                    SPAccount *aacc = [SPAccount accountWithDict:[weakSelf jsonConvertDic:responseObject][@"info"]];
                    
                    [SPAccountTool saveAccount:aacc];
                    
                    if ([[weakSelf jsonConvertDic:responseObject][@"code"] integerValue] ==200) {
                        [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                        HxwTabBarController *hxwVc = [[HxwTabBarController alloc]init];
                        JTBaseNavigationController *rootVc = [[JTBaseNavigationController alloc]initWithRootViewController:hxwVc];
                        del.window.rootViewController = rootVc;
                    }
                }];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
                NSLog(@"dddd");
                
            }];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
                                    
- (void)LoginPress{
   
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"ycby" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendAuthReq:req viewController:self delegate:self];
}

-(NSDictionary *)jsonConvertDic:(id)res{
    
    NSString *receiveStr = [[NSString alloc]initWithData:res encoding:NSUTF8StringEncoding];
    
    NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return jsonDict;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

