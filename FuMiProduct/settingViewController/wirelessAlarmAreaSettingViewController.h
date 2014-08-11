//
//  wirelessAlarmAreaSettingViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "wirelessAlarmDeviceCell.h"
#import "wirelessAlarmDeviceModel.h"

@interface wirelessAlarmAreaSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,SKSTableViewDelegate,wirelessAlarmDeviceCellDelegate>
{
    NSArray* _nameArray;
    wirelessAlarmDeviceCell* _deviceCell;
    
    wirelessAlarmDeviceModel* _deviceModel;
    NSMutableArray* _commonFQArray;
    NSMutableArray* _homeFQArray;
    NSMutableArray* _allDayFQArray;
    
    NSMutableDictionary* _deviceTypeDic;
    commonRespondModel* _commRespondModel;
}

@property (strong,nonatomic) NSMutableArray* alarmDeviceArray;
@property (weak, nonatomic) IBOutlet SKSTableView *tableView;
- (IBAction)backButtonTouched:(UIButton *)sender;

@end
