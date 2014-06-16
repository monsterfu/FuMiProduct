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

@interface mainViewController : UIViewController<CustomSwitchDelegate>
{
    NSString* _telephoneName;
    hostPropertyModel* _hostPropertyModel;
}


@property (strong,nonatomic) NSMutableArray* hostDeviceArray;
@property (strong,nonatomic) NSMutableArray* alarmDeviceArray;
@property (strong,nonatomic) NSMutableArray* rfidDeviceArray;

@property (nonatomic, strong)hostLogoModel* hostLogoModel;
@property (nonatomic, strong)commonRespondModel* commRespondModel;

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

@end
