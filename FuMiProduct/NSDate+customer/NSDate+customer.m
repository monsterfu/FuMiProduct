//
//  NSDate+customer.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-7-22.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "NSDate+customer.h"

@implementation NSDate (customer)

+(NSDate*)dateWithString:(NSString*)dateStr
{
    if (dateStr.length < 14) {
        return nil;
    }
    NSUInteger year = [[dateStr substringWithRange:NSMakeRange(0,4)] intValue];
    NSUInteger month = [[dateStr substringWithRange:NSMakeRange(4,2)] intValue];
    NSUInteger day = [[dateStr substringWithRange:NSMakeRange(6,2)] intValue];
    NSUInteger hour = [[dateStr substringWithRange:NSMakeRange(8,2)] intValue];
    NSUInteger min = [[dateStr substringWithRange:NSMakeRange(10,2)] intValue];
    NSUInteger sec = [[dateStr substringWithRange:NSMakeRange(12,2)] intValue];
    return [NSDate dateWithYear:year Month:month Day:day Hours:hour Min:min Sec:sec];
}

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

+(NSDate *)convertDateToLocalTime: (NSDate *)forDate {
    NSTimeZone *nowTimeZone = [NSTimeZone localTimeZone];
    int timeOffset = [nowTimeZone secondsFromGMTForDate:forDate];
    NSDate *newDate = [forDate dateByAddingTimeInterval:timeOffset];
    return newDate;
}
@end
