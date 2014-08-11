//
//  rfidDeviceCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "rfidDeviceCell.h"
#import "NSString+userName.h"
#import "NSString+random.h"
#import "GlobalHeader.h"

@implementation rfidDeviceCell

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

-(void)setRfidModel:(rfidDeviceModel *)rfidModel
{
    _rfidModel = rfidModel;
    _deviceNameField.text = rfidModel.name;
    _deviceNameField.delegate = self;
}
- (IBAction)deviceNameFieldEditEnd:(UITextField *)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [ProgressHUD show:@"修改设备名，请稍候"];
        [_deviceNameField resignFirstResponder];
        _name = _rfidModel.name;
        _rfidModel.name = textField.text;
        _rfidModel.opertype = OperType_Mof;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(rfidSet:num:)]) {
            [self.delegate rfidSet:_rfidModel num:self.tag];
        }
    }
    return YES;
}

@end
