//
//  selectDeviceViewController.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "deviceTableViewCell.h"
#import "hostLogoModel.h"
#import "GlobalHeader.h"

#import "loginViewController.h"

@interface selectDeviceViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    deviceTableViewCell* _deviceCell;
    hostLogoModel* _hostLogo;
}

@property (nonatomic, strong)NSMutableArray* hostDeviceArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)backButtonTouched:(UIButton *)sender;

@end
