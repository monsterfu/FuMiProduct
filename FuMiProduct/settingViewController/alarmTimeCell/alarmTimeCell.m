//
//  alarmTimeCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "alarmTimeCell.h"

@implementation alarmTimeCell

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
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateTimeValue:)]) {
        [self.delegate updateTimeValue:sender.value];
    }
}

-(void)setCellValue:(NSUInteger)value
{
    _slider.value = value;
    _label.text = [NSString stringWithFormat:@"%d",value];
}
@end
