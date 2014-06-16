//
//  NSString+userName.m
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "NSString+userName.h"
#import "GlobalHeader.h"

@implementation NSString (userName)

+(NSString*)userName
{
    return [[USER_DEFAULT objectForKey:KEY_USERNAME] stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

+(NSString*)hostId
{
    return [USER_DEFAULT objectForKey:KEY_HOSTID];
}
@end
