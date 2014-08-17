//
//  Commonality.h
//  IVMall (Ipad)
//
//  Created by sean on 14-2-24.
//  Copyright (c) 2014年 HYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commonality : NSObject

+ (BOOL) isEmpty:(NSString *)nsstring;

+ (void)showErrorMsg:(UIView*)view type:(int)type msg:(NSString *)msg;

+(int) isEnableWIFI;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+(BOOL)determineCellPhoneNumber:(NSString*)str;

+(NSString*)MD5:(NSString*)str;

+ (int)judgeDate:(NSString*)onday withday:(NSString*)withday;

+ (NSString *)SystemDate2Str;

+ (UIColor *) colorFromHexRGB:(NSString *) inColorString;

+(void)dismissAllView;
+(void)dismissAllView1;
+(void)clickUserBtn;

+(void) setImgViewStyle:(UIView *) myView;

+ (int) judgePasswordStrength:(NSString*) _password;

+(void)anmou1View:(UIView*)view delegate:(id)delegaet;

+ (UIImage *) imageFromColor:(UIColor *)color;

+(UIView *) makeButtonShadowViewWhitbtn:(UIButton *)btn;

@end
