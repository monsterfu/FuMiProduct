//
//  alarmVolumeCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmVolumeCell.h"

@implementation alarmVolumeCell

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

- (IBAction)sliderValueChanged:(UISlider *)sender {
    _label.text = [NSString stringWithFormat:@"%.0f",sender.value];
}

- (IBAction)sliderTouchUpInside:(UISlider *)sender {
    _label.text = [NSString stringWithFormat:@"%.0f",sender.value];
    
//    [HttpRequest rfidSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] rfidDevice:_rfidModel delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    
//    [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:@"福米" email:@"" question:@"" answer:@"" workstatus:HostWorkSts_LJSF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_LJSF];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateVolumeValue:)]) {
        [self.delegate updateVolumeValue:sender.value];
    }
    
}

-(void)setCellValue:(NSUInteger)value
{
    _sliderView.value = value;
    _label.text = [NSString stringWithFormat:@"%d",value];
}
@end
