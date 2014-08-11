//
//  wirelessAlarmDeviceCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "wirelessAlarmDeviceCell.h"
#import "NSString+userName.h"
#import "NSString+random.h"

@implementation wirelessAlarmDeviceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDeviceModel:(wirelessAlarmDeviceModel *)deviceModel
{
    
    _deviceModel = deviceModel;
    _nameField.delegate = self;
    _nameLabel.text = deviceModel.type;
    _nameField.text = deviceModel.name;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [ProgressHUD show:@"修改报警设备名，请稍候"];
        [_nameField resignFirstResponder];
        _deviceModel.name = textField.text;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(wirelessAlarmDeviceSet:num:)]) {
            [self.delegate wirelessAlarmDeviceSet:_deviceModel num:self.tag];
        }
//        [HttpRequest wirelessAlarmDeviceSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] wirelessAlarmDevice:_deviceModel delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        [ProgressHUD show:@"设备名无效，请重新设置!"];
    }
    return YES;
}


@end
