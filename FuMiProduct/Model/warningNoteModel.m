//
//  warningNoteModel.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-7-22.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "warningNoteModel.h"

@implementation warningNoteModel
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
    {
        _msgcode = [dictionary objectForKey:@"msgcode"];
        _seqno = [dictionary objectForKey:@"seqno"];
        _respcode = [dictionary objectForKey:@"respcode"];
        _respinfo = [dictionary objectForKey:@"respinfo"];
        _starttime = [dictionary objectForKey:@"begintime"];
        _endtime = [dictionary objectForKey:@"endtime"];
        
        NSArray* arr1=[dictionary objectForKey:@"alarmmessages"];
        _alarmessageArray = [NSMutableArray array];
        for (NSDictionary*dic in arr1) {
            alarmMessageModel* _alarmmessages = [[alarmMessageModel alloc]initWithDictionary:dic];
            [_alarmessageArray addObject:_alarmmessages];
        }
    }
    return self;
    
}
@end
