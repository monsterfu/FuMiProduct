//
//  mainViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "commonRespondModel.h"
#import "hostPropertyModel.h"
#import "warningNoteModel.h"
#import "loginModel.h"
#import "settingViewController.h"

@interface mainViewController : UIViewController<CustomSwitchDelegate,PAPasscodeViewControllerDelegate,UITextFieldDelegate,MFMessageComposeViewControllerDelegate>
{
    NSString* _telephoneName;
    hostPropertyModel* _hostPropertyModel;
    BOOL _enterPassWordGapIsDone;  //输入密码错误后的时间间隔是否已到
    NSTimer* _enterPasswordTimer;
    loginModel* _loginModel;
    warningNoteModel* _warningNoteModel;
    MFMessageComposeViewController* _picker;
    settingViewController* _settingViewController;
}


@property (strong,nonatomic) NSMutableArray* hostDeviceArray;
@property (strong,nonatomic) NSMutableArray* alarmDeviceArray;
@property (strong,nonatomic) NSMutableArray* rfidDeviceArray;
@property (strong,nonatomic) NSMutableArray* alarmPhoneArray;//报警电话

@property (nonatomic, strong)hostLogoModel* hostLogoModel;
@property (nonatomic, strong)commonRespondModel* commRespondModel;


//布防状态切换的三个按钮
@property (weak, nonatomic) IBOutlet UIButton *systemBastionButton;
@property (weak, nonatomic) IBOutlet UIButton *homeBastionButton;
@property (weak, nonatomic) IBOutlet UIButton *systemCancelBastionButton;

- (IBAction)systemBastionButtonTouch:(UIButton *)sender;
- (IBAction)homeBastionButtonTouch:(UIButton *)sender;
- (IBAction)systemCancelBastionButtonTouch:(UIButton *)sender;



@property (weak, nonatomic) IBOutlet CustomSwitch *systemBastion;
@property (weak, nonatomic) IBOutlet CustomSwitch *homeBastion;
@property (weak, nonatomic) IBOutlet CustomSwitch *systemCancelBastion;

@property (weak, nonatomic) IBOutlet UIButton *statusButton;

- (IBAction)backButtonTouched:(UIButton *)sender;


//离家设防
- (IBAction)bastionTouched:(UIButton *)sender;
//报警日志查看
- (IBAction)warningLogTouched:(UIButton *)sender;
//视频通话
- (IBAction)videoTelephoneTouched:(UIButton *)sender;
//留言
- (IBAction)messageTouched:(UIButton *)sender;
//客服
- (IBAction)customerServiceTouched:(UIButton *)sender;
//刷新最新
- (IBAction)refreshStatusButtonTouch:(UIButton *)sender;
//主机名
@property (weak, nonatomic) IBOutlet UITextField *hostNameTextField;

@end
