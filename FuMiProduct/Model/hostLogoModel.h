//
//  hostLogoModel.h
//  FuMiProduct
//
//  Created by Monster on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hostLogoModel : NSObject
@property(nonatomic, strong)NSString* hostid;
@property(nonatomic, strong)NSString* name;

- (id)initWithDictionary:(NSDictionary *)dictionary;
@end
