//
//  deviceListModel.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "deviceListModel.h"

@implementation deviceListModel
- (id)initWithDictionary:(NSDictionary *)dictionary hostArray:(NSMutableArray*)hostArray
{
    if (self = [super init])
    {
        _msgcode = [dictionary objectForKey:@"msgcode"];
        _seqno = [dictionary objectForKey:@"seqno"];
        _respcode = [dictionary objectForKey:@"respcode"];
        _respinfo = [dictionary objectForKey:@"respinfo"];
        
        NSArray* arr1=[dictionary objectForKey:@"hostlogos"];
        for (NSDictionary*dic in arr1) {
            [hostArray addObject:[[hostLogoModel alloc]initWithDictionary:dic]];
        }
    }
    return self;
    
}
@end
