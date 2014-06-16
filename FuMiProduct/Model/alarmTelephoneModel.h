//
//  alarmTelephoneModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-6.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface alarmTelephoneModel : NSObject
@property(nonatomic,strong)NSString* alarmphone;        //报警电话
@property(nonatomic,strong)NSString* phonetype;         //电话类型
@property(nonatomic,strong)NSString* opertype;          //操作类型

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
