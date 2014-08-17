//
//  settingViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "deleyTimeCell.h"
#import "rfidDeviceCell.h"
#import "alarmNumCell.h"
#import "alarmVolumeCell.h"
#import "alarmTimeCell.h"
#import "passwordSwitchCell.h"
#import "wirelessAlarmAreaSettingViewController.h"

@interface settingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate,alarmTimeCellDelegate,alarmVolumeCellDelegate,deleyTimeCellDelegate,passwordSwitchCellDelegate,rfidDeviceCellDelegate,alarmNumCellDelegate>
{
    NSArray* _nameArray;
    deleyTimeCell* _deleyTimeCell;
    rfidDeviceCell* _rfidDeviceCell;
    alarmNumCell* _alarmNumCell;
    alarmVolumeCell* _alarmVolumeCell;
    alarmTimeCell* _alarmTimeCell;
    passwordSwitchCell* _passwordSwitchCell;
    commonRespondModel* _commRespondModel;
}
@property (strong,nonatomic)hostPropertyModel* hostPropertyModel;

@property (strong,nonatomic) NSMutableArray* hostDeviceArray;
@property (strong,nonatomic) NSMutableArray* alarmDeviceArray;
@property (strong,nonatomic) NSMutableArray* rfidDeviceArray;
@property (strong,nonatomic) NSMutableArray* alarmPhoneArray;

@property (weak, nonatomic) IBOutlet SKSTableView *tableView;

- (IBAction)backButtonTouched:(UIButton *)sender;

@end
