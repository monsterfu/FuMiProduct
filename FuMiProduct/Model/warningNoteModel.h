//
//  warningNoteModel.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-7-22.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "alarmMessageModel.h"
@interface warningNoteModel : NSObject
@property(nonatomic, strong)NSString* msgcode;
@property(nonatomic, strong)NSString* seqno;
@property(nonatomic, strong)NSString* respcode;
@property(nonatomic, strong)NSString* respinfo;
@property(nonatomic, strong)NSString* starttime;
@property(nonatomic, strong)NSString* endtime;
@property(nonatomic, strong)NSMutableArray* alarmessageArray;//alarmMessageModel* alarmmessages; 数组
//@property(nonatomic, strong)alarmMessageModel* alarmmessages;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
