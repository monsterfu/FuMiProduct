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


@protocol wirelessAlarmDeviceCellDelegate <NSObject>
-(void)wirelessAlarmDeviceSet:(wirelessAlarmDeviceModel*)deviceModel num:(NSUInteger)tag;
@end

@interface wirelessAlarmDeviceCell : UITableViewCell<UITextFieldDelegate>
{
    NSArray* _deviceTypeArray;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) id<wirelessAlarmDeviceCellDelegate>delegate;

@property(nonatomic, strong)wirelessAlarmDeviceModel* deviceModel;
@property (nonatomic, assign)NSUInteger tag;
@end
