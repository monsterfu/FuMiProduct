//
//  loginViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-1.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "loginModel.h"
#import "synchrDataModel.h"

#import "hostLogoModel.h"

@interface loginViewController : UIViewController<UITextFieldDelegate>
{
    loginModel* _loginModel;
    synchrDataModel* _synchrDataModel;
    NSMutableArray* _hostDeviceArray;
    NSMutableArray* _alarmDeviceArray;
    NSMutableArray* _rfidDeviceArray;
    
    NSMutableArray* _hostFetchedArray;
}
@property (nonatomic, strong)hostLogoModel* hostLogoModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

- (IBAction)userNameFieldEditingEnd:(UITextField *)sender;
- (IBAction)passWordFieldEditingEnd:(UITextField *)sender;


- (IBAction)loginTouched:(UIButton *)sender;
- (IBAction)changeOpenStatus:(id)sender;
- (IBAction)backButtonTouched:(UIButton *)sender;

@end
