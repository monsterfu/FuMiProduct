//
//  alarmMessageCellModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alarmMessageCellModel : NSObject

@property(nonatomic,strong)NSString* time;              //警报时间
@property(nonatomic,strong)NSString* content;          //警报消息

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
