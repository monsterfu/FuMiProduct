//
//  passwordSwitchCell.h
//  FuMiProduct
//
//  Created by Monster on 14-7-15.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSwitch.h"


@interface passwordSwitchCell : UITableViewCell<CustomSwitchDelegate>

@property (weak, nonatomic) IBOutlet CustomSwitch *passwordOpenSwitch;

-(void)setSwitchUI;
@end
