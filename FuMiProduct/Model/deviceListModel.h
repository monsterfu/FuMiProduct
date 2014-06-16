//
//  deviceListModel.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "hostLogoModel.h"

@interface deviceListModel : NSObject

@property(nonatomic,strong)NSString* msgcode;
@property(nonatomic,strong)NSString* seqno;
@property(nonatomic,strong)NSString* respcode;
@property(nonatomic,strong)NSString* respinfo;

- (id)initWithDictionary:(NSDictionary *)dictionary hostArray:(NSMutableArray*)hostArray;
@end
