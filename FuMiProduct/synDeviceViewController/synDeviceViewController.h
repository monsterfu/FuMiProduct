//
//  synDeviceViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "deviceListModel.h"

#import "selectDeviceViewController.h"


@interface synDeviceViewController : UIViewController<UITextFieldDelegate>
{
    NSMutableArray* _hostDeviceArray;
    deviceListModel* _deviceListModel;
}

@property (nonatomic, strong)NSMutableArray* hostDeviceArray;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;

- (IBAction)synButton:(UIButton *)sender;
@end
