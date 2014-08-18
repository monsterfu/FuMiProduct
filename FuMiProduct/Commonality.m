//
//  Commonality.m
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import "Commonality.h"
#import "Reachability.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
#import <CommonCrypto/CommonDigest.h>
#import "AppDelegate.h"
@implementation Commonality


+ (UIImage *) imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 30, 30);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
+ (BOOL) isEmpty:(NSString *)nsstring{
    if(nsstring){
        if(nsstring.length>0){
            if(![nsstring isEqualToString:@"null"]){
                return false;
            }
        }
    }
    return true;
}

+(BOOL)determineCellPhoneNumber:(NSString*)str{
    return YES;
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(16[0-9])|(18[0,1,2,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}


+(int) isEnableWIFI{
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable) {
        return 0;
    }
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi) {
        return 1;
    }
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==kReachableViaWWAN) {
        return 2;
    }
    return 2;
}
+(NSString*)MD5:(NSString*)str{
    const char *concat_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(concat_str, strlen(concat_str), result);
    NSMutableString *hash =[NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}

+ (NSString *)SystemDate2Str{
    NSDate *  indate=[NSDate date];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
	dateFormatter.dateFormat = @"yyyy-MM-dd";
	NSString *tempstr = [dateFormatter stringFromDate:indate];
	return tempstr;
}

+ (int)judgeDate:(NSString*)onday withday:(NSString*)withday{
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    [dateFromatter setDateFormat:@"yy/MM/dd"];
    NSDate *day1 = [dateFromatter dateFromString:onday];
    NSDate *day2 = [dateFromatter dateFromString:withday];
    
    NSComparisonResult result = [day1 compare:day2];
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
}

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString
{
    UIColor *result = nil;
    unsigned int colorCode = 0;
    unsigned char redByte, greenByte, blueByte;
    
    if (nil != inColorString)
    {
        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
        (void) [scanner scanHexInt:&colorCode]; // ignore error
    }
    redByte = (unsigned char) (colorCode >> 16);
    greenByte = (unsigned char) (colorCode >> 8);
    blueByte = (unsigned char) (colorCode); // masks off high bits
    result = [UIColor
              colorWithRed: (float)redByte / 0xff
              green: (float)greenByte/ 0xff
              blue: (float)blueByte / 0xff
              alpha:1.0];
    return result;
}
    

+(void)dismissAllView1
{
//    if (![AppDelegate App].userView.hihel) {
//        [[AppDelegate App].userView dismiss];
//    }
//
//    if ([AppDelegate App].registView.hihel) {
//        [[AppDelegate App].registView dismiss];
//    }
//    
//    if ([AppDelegate App].collect.hihel) {
//        [[AppDelegate App].collect dismiss];
//    }
//    
//    if ([AppDelegate App].buyView.hihel) {
//        [[AppDelegate App].buyView dismiss];
//    }
//    
//    if ([AppDelegate App].rechargeRecordView.hihel) {
//        [[AppDelegate App].rechargeRecordView dismiss];
//    }
//
//    if ([AppDelegate App].aboutUsView.hihel) {
//        [[AppDelegate App].aboutUsView dismiss];
//    }
//
//    if ([AppDelegate App].forgetPasswordView.hihel) {
//        [[AppDelegate App].forgetPasswordView dismiss];
//    }
//    
//    if ([AppDelegate App].playedTimeView.hihel) {
//        [[AppDelegate App].playedTimeView dismiss];
//    }
//    
//    if ([AppDelegate App].playHistVIew.hihel) {
//        [[AppDelegate App].playHistVIew dismiss];
//    }
//    else
//    {
//        [[AppDelegate App].playHistVIew show];
//    }

}

+(void)dismissAllView{
    
//    if ([AppDelegate App].registView.hihel) {
//        [[AppDelegate App].registView dismiss];
//    }
//    
//    if ([AppDelegate App].collect.hihel) {
//        [[AppDelegate App].collect dismiss];
//    }
//    
//    if ([AppDelegate App].buyView.hihel) {
//        [[AppDelegate App].buyView dismiss];
//    }
//    
//    if ([AppDelegate App].rechargeRecordView.hihel) {
//        [[AppDelegate App].rechargeRecordView dismiss];
//    }
//    
//    
//    if ([AppDelegate App].aboutUsView.hihel) {
//        [[AppDelegate App].aboutUsView dismiss];
//    }
//    
//    if ([AppDelegate App].forgetPasswordView.hihel) {
//        [[AppDelegate App].forgetPasswordView dismiss];
//    }
//    
//    if ([AppDelegate App].playHistVIew.hihel) {
//        [[AppDelegate App].playHistVIew dismiss];
//    }
//    
//    if ([AppDelegate App].vipListView.hihel) {
//        [[AppDelegate App].vipListView dismiss];
//    }
//    
//    if ([AppDelegate App].playedTimeView.hihel) {
//        [[AppDelegate App].playedTimeView dismiss];
//    }
//    
//    if ([AppDelegate App].userView.hihel) {
//        [[AppDelegate App].userView show];
//        [[AppDelegate App].userView mackNoLongInView];
//    }
//    else
//    {
//        [[AppDelegate App].userView dismiss];
//    }
//
}

+(void)clickUserBtn{
    
//    if ([AppDelegate App].registView.hihel) {
//        [[AppDelegate App].registView dismiss];
//    }
//    
//    if ([AppDelegate App].collect.hihel) {
//        [[AppDelegate App].collect dismiss];
//    }
//    
//    if ([AppDelegate App].buyView.hihel) {
//        [[AppDelegate App].buyView dismiss];
//    }
//    
//    if ([AppDelegate App].rechargeRecordView.hihel) {
//        [[AppDelegate App].rechargeRecordView dismiss];
//    }
//    
//    
//    if ([AppDelegate App].aboutUsView.hihel) {
//        [[AppDelegate App].aboutUsView dismiss];
//    }
//    
//    if ([AppDelegate App].forgetPasswordView.hihel) {
//        [[AppDelegate App].forgetPasswordView dismiss];
//    }
//    
//    if ([AppDelegate App].playHistVIew.hihel) {
//        [[AppDelegate App].playHistVIew dismiss];
//    }
//    
//    if ([AppDelegate App].vipListView.hihel) {
//        [[AppDelegate App].vipListView dismiss];
//    }
//    
//    if ([AppDelegate App].playedTimeView.hihel) {
//        [[AppDelegate App].playedTimeView dismiss];
//    }
//    
//    if ([AppDelegate App].userView.hihel) {
//        [[AppDelegate App].userView show];
//    }
//    else
//    {
//        [[AppDelegate App].userView dismiss];
//    }
    
}

+(void)anmou1View:(UIView*)view delegate:(id)delegaet{
    [view setTransform:CGAffineTransformScale(view.transform,0,0)];
 
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:delegaet];
    [view setTransform:CGAffineTransformIdentity];
    [UIView commitAnimations];
    
    [UIView beginAnimations:@"" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:delegaet];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft  forView:view cache:YES];
    [UIView commitAnimations];

}


+(void) setImgViewStyle:(UIView *) myView
{
    myView.layer.borderWidth = 1;
    myView.layer.borderColor = [UIColor clearColor].CGColor;
    myView.layer.shadowOffset = CGSizeMake(0, 0);
    myView.layer.shadowRadius = 10;
    myView.layer.shadowOpacity = 0.5;
    myView.layer.shadowPath = [UIBezierPath bezierPathWithRect:myView.bounds].CGPath;
}

+ (BOOL) judgeRange:(NSArray*) _termArray Password:(NSString*) _password{
    
    NSRange range;
    
    BOOL result =NO;
    
    for(int i=0; i<[_termArray count]; i++)
    {
        range = [_password rangeOfString:[_termArray objectAtIndex:i]];
        if(range.location != NSNotFound){
            result =YES;
        }
    }
    
    return result;
    
}


+ (int) judgePasswordStrength:(NSString*) _password{
    
    NSMutableArray* resultArray = [[NSMutableArray alloc] init];
    
    
    NSArray* termArray1 = [[NSArray alloc] initWithObjects:@"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    NSArray* termArray2 = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", nil];
    
    NSArray* termArray3 = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    NSArray* termArray4 = [[NSArray alloc] initWithObjects:@"~",@"`",@"@",@"#",@"$",@"%",@"^",@"&",@"*",@"(",@")",@"-",@"_",@"+",@"=",@"{",@"}",@"[",@"]",@"|",@":",@";",@"“",@"'",@"‘",@"<",@",",@".",@">",@"?",@"/",@"、", nil];
    
    
    
    NSString* result1 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray1 Password:_password]];
    
    NSString* result2 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray2 Password:_password]];
    
    NSString* result3 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray3 Password:_password]];
    
    NSString* result4 = [NSString stringWithFormat:@"%d",[self judgeRange:termArray4 Password:_password]];
    
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result1]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result2]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result3]];
    
    [resultArray addObject:[NSString stringWithFormat:@"%@",result4]];
    
    
    int intResult=0;
    
    for (int j=0; j<[resultArray count]; j++){
        if ([[resultArray objectAtIndex:j] isEqualToString:@"1"]){
            intResult++;
        }
    }
    
    int resultInt=0;
    
    if (intResult <2){
        resultInt = 0;
    }else if (intResult == 2&&[_password length]>=6){
        resultInt = 1;
    }else if (intResult > 2&&[_password length]>=6){
        resultInt = 2;
    }
    
    return resultInt;
}

+(UIView *) makeButtonShadowViewWhitbtn:(UIButton *)btn
{
    UIView * backView = [[UIView alloc] initWithFrame:btn.frame];
    
    backView.layer.cornerRadius = btn.layer.cornerRadius;
//    self.layer.borderWidth = 3;
//    self.layer.borderColor = [[UIColor whiteColor] CGColor];
    //阴影
    backView.layer.shadowColor = [[UIColor lightGrayColor] CGColor];
//    backView.layer.shadowColor = [color_18 CGColor];
    backView.layer.shadowOffset = CGSizeMake(0, 2.0f); //[水平偏移, 垂直偏移]
    backView.layer.shadowOpacity = 10.0f; // 0.0 ~ 1.0 的值
    backView.layer.shadowRadius = 1.0f; // 阴影发散的程度
    btn.frame = CGRectMake(0, 0, btn.frame.size.width, btn.frame.size.height);
    [backView addSubview:btn];
    
    return backView;
    
}


@end
