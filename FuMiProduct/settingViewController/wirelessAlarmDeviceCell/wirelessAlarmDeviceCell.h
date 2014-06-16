//
//  wirelessAlarmDeviceCell.h
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "wirelessAlarmDeviceModel.h"

@interface wirelessAlarmDeviceCell : UITableViewCell<UITextFieldDelegate>
{
    commonRespondModel* _commRespondModel;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;


@property(nonatomic, strong)wirelessAlarmDeviceModel* deviceModel;
@end
