//
//  alarmMessageModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "alarmMessageCellModel.h"

@interface alarmMessageModel : NSObject

@property(nonatomic,strong)NSString* type;              //设备类型
@property(nonatomic,strong)NSString* deveceid;          //设备编号
@property(nonatomic,strong)NSString* name;              //设备名称
@property(nonatomic,strong)NSString* time;              //警报时间
@property(nonatomic,strong)NSString* content;          //警报消息

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
