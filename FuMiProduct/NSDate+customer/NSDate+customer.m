//
//  NSDate+customer.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-7-22.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "NSDate+customer.h"

@implementation NSDate (customer)
+(NSDate*)dateWithYear:(NSUInteger)year Month:(NSUInteger)month Day:(NSUInteger)day Hours:(NSUInteger)hour Min:(NSUInteger)min Sec:(NSUInteger)sec
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    [cal setTimeZone:[NSTimeZone localTimeZone]];
    [cal setLocale:[NSLocale currentLocale]];
    
    NSDateComponents *toTimeComponents = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit ) fromDate:[NSDate date]];
    [toTimeComponents setYear:year];
    [toTimeComponents setMonth:month];
    [toTimeComponents setDay:day];
    [toTimeComponents setHour:hour];
    [toTimeComponents setMinute:min];
    [toTimeComponents setSecond:sec];
    return [cal dateFromComponents:toTimeComponents];
}
@end
