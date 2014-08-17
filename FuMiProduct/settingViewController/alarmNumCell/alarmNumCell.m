//
//  alarmNumCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmNumCell.h"
#import "NSString+userName.h"
#import "NSString+random.h"

@implementation alarmNumCell

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
    _phoneNumField.delegate = self;
}

-(void)setAlarmTeleModel:(alarmTelephoneModel *)alarmTeleModel
{
    _alarmTeleModel = alarmTeleModel;
    _phoneNumField.text = alarmTeleModel.alarmphone;
     _phoneNumField.delegate = self;
}

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([self isMobileNumber:textField.text]) {
        [_phoneNumField resignFirstResponder];
        if (_alarmTeleModel == nil) {
            _alarmTeleModel = [[alarmTelephoneModel alloc]init];
            _alarmTeleModel.phonetype = AlramPhoneType_OnlyReciveAlarmMsg;
            _alarmTeleModel.opertype = OperType_Add;
        }
        _alarmTeleModel.alarmphone = textField.text;
        
        if (self.delegate&&[self.delegate respondsToSelector:@selector(alarmNumCellupdatePhoneNum:num:)]) {
            [self.delegate alarmNumCellupdatePhoneNum:_alarmTeleModel num:self.tag];
        }
        
    }
    return YES;
}
@end
