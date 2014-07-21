//
//  NSString+dateFormater.m
//  FuMiProduct
//
//  Created by Monster on 14-7-21.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "NSString+dateFormater.h"

@implementation NSString (dateFormater)

+(NSString*)dateFormater:(NSDate*)date
{
    NSString* description = [date description];
    description = [description stringByReplacingOccurrencesOfString:@"-" withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@" " withString:@""];
    description = [description stringByReplacingOccurrencesOfString:@":" withString:@""];
    description = [description substringToIndex:14];
    return description;
}
@end
