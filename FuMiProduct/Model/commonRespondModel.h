//
//  commonRespondModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface commonRespondModel : NSObject

@property(nonatomic,strong)NSString* msgcode;
@property(nonatomic,strong)NSString* seqno;
@property(nonatomic,strong)NSString* respcode;
@property(nonatomic,strong)NSString* respinfo;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
