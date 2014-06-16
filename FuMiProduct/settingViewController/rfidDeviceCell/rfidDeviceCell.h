//
//  rfidDeviceCell.h
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "rfidDeviceModel.h"
#import "GlobalHeader.h"
#import "commonRespondModel.h"
@interface rfidDeviceCell : UITableViewCell<UITextFieldDelegate>
{
    NSString* _name;
    commonRespondModel* _commRespondModel;
}
@property (weak, nonatomic) IBOutlet UITextField *deviceNameField;
- (IBAction)deviceNameFieldEditEnd:(UITextField *)sender;

@property (nonatomic, strong)rfidDeviceModel* rfidModel;
@end
