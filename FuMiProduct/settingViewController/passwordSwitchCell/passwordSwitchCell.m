//
//  passwordSwitchCell.m
//  FuMiProduct
//
//  Created by Monster on 14-7-15.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "passwordSwitchCell.h"

@implementation passwordSwitchCell

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

-(void)setSwitchUI:(BOOL)open
{
    _passwordOpenSwitch.arrange = CustomSwitchArrangeONLeftOFFRight;
    _passwordOpenSwitch.onImage = [UIImage imageNamed:@"on.png"];
    _passwordOpenSwitch.offImage = [UIImage imageNamed:@"off.png"];
    if (open) {
        _passwordOpenSwitch.status = CustomSwitchStatusOn;
    }else{
        _passwordOpenSwitch.status = CustomSwitchStatusOff;
    }
    _passwordOpenSwitch.delegate = self;
}


#pragma mark - CustomSwitchDelegate
-(void)customSwitch:(CustomSwitch*)customSwitch SetStatus:(CustomSwitchStatus)status
{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(openPassword:)]) {
        if (status == CustomSwitchStatusOn) {
            [self.delegate openPassword:YES];
        }else{
            [self.delegate openPassword:NO];
        }
        
    }
}
@end
