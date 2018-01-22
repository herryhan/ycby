//
//  hudCustom.m
//  ZTMall
//
//  Created by 庄园 on 16/12/21.
//  Copyright © 2016年 ztsm. All rights reserved.
//

#import "hudCustom.h"

@implementation hudCustom

+ (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
   // hud.yOffset = 120;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

+ (BOOL) isValidateMobileNumber:(NSString *)mobileNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,147,150,151,152,157,158,159,178,182,183,184,187,188
     * 联通：130,131,132,155,156,185,186,145,176
     * 电信：133,1349,153,180,181,189
     */
    NSString *MOBILE = @"^1(3[0-9]|4[47]|5[0-35-9]|7[68]|8[0-9])\\d{8}$";
    
    /**
     * 中国移动
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     */
    NSString * CU = @"^1(3[0-2]|4[5]|5[256]|7[6]|8[56])\\d{8}$";
    /**
     * 中国电信
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        return YES;
    }
    else{
        return NO;
    }
}
+ (NSString *)calculateOneDate:(NSString *)dateString1 To:(NSString *)dateString2{

    NSDate *nowDate = [NSDate date]; // 当前时间
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [formatter dateFromString:dateString1]; // 传入的时间
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:creat toDate:nowDate options:0];
    NSLog(@"year=%zd  month=%zd  day=%zd hour=%zd  minute=%zd",compas.year,compas.month,compas.day,compas.hour,compas.minute);
    return [NSString stringWithFormat:@"%ld",compas.month];
}

+ (NSMutableAttributedString *)convertNumColor:(NSString *)contentString withFontSize:(NSInteger)fontSize{
    
    NSArray * number = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"."];
    NSMutableAttributedString * attributeString  = [[NSMutableAttributedString alloc]initWithString:contentString];
    for (int i = 0; i < contentString.length; i ++) {
        //每次只截取一个字符的范围
        NSString * str = [contentString substringWithRange:NSMakeRange(i, 1)];
        //判断装有0-9的字符串的数字数组是否包含截取字符串出来的单个字符，从而筛选出符合要求的数字字符的范围NSMakeRange
        if ([number containsObject:str]) {
            [attributeString setAttributes:@{NSForegroundColorAttributeName:UIColorFromRGBA(202, 44, 51, 1),NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} range:NSMakeRange(i, 1)];
        }
    }
    return attributeString;
    
}
@end
