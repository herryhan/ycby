//
//  AppDelegate.h
//  一筹百应
//
//  Created by 庄园 on 17/10/7.
//  Copyright © 2017年 择善基金. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HxwTabBarController.h"
#import "LoginViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HxwTabBarController *hxwTAB;

@property (strong, nonatomic) LoginViewController *LoginVc;

@end

