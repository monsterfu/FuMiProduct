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
        [HttpRequest rfidSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] rfidDevice:_rfidModel delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }
    return YES;
}
#pragma mark -http result

-(void) GetErr:(ASIHTTPRequest *)request
{
    _deviceNameField.text = _name;
    [ProgressHUD showError:@"修改设备名失败"];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    //    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"pageSource:%@",pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSLog(@"dic is %@",dictionary);
    if(dictionary!=nil){
        _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
        if ([_commRespondModel.respcode intValue]!= respcode_Success) {
            [ProgressHUD showError:_commRespondModel.respinfo];
            _deviceNameField.text = _name;
        }else{
            [ProgressHUD showSuccess:@"设置成功！"];
        }
    }else{
        [ProgressHUD showError:_commRespondModel.respinfo];
        _deviceNameField.text = _name;
    }
}
@end
