//
//  AppDelegate.m
//  一筹百应
//
//  Created by 庄园 on 17/10/7.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import "AppDelegate.h"
#import "JTBaseNavigationController.h"

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    JTBaseNavigationController * rootView = nil;
    if ([SPAccountTool account].token.length >0) {
        self.hxwTAB=[[HxwTabBarController alloc]init];
        rootView = [[JTBaseNavigationController alloc]initWithRootViewController:self.hxwTAB];
    }else{
        self.LoginVc = [[LoginViewController alloc]init];
        rootView = [[JTBaseNavigationController alloc]initWithRootViewController:self.LoginVc];
    }
    self.window.rootViewController = rootView;
    
    [WXApi registerApp:@"wx4dc3912fdae00437"];
    
    [self.window makeKeyAndVisible];
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *rep = (SendAuthResp *)resp;
        if (rep.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WXLoginSuccess" object:@{@"code":rep.code}];
        }
    }
}
    

@end
