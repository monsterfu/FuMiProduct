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
    _nameLabel.text = deviceModel.deveceid;
    _nameField.text = deviceModel.name;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.text.length) {
        [ProgressHUD show:@"修改报警设备名，请稍候"];
        [_nameField resignFirstResponder];
        [HttpRequest wirelessAlarmDeviceSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] wirelessAlarmDevice:_deviceModel delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    }else{
        [ProgressHUD show:@"设备名无效，请重新设置!"];
    }
    return YES;
}

#pragma mark -http result

-(void) GetErr:(ASIHTTPRequest *)request
{
    [ProgressHUD showError:@"修改报警设备名失败"];
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
        }else{
            [ProgressHUD showSuccess:@"修改报警设备名成功!"];
        }
    }else{
        [ProgressHUD showError:_commRespondModel.respinfo];
    }
}
@end
