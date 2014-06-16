//
//  deleyTimeCell.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "deleyTimeCell.h"

@implementation deleyTimeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _timeLabel.text = [NSString stringWithFormat:@"%.0f",_timerSlier.value];
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

- (IBAction)timeSlider:(UISlider *)sender {
    _timeLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
}

- (IBAction)timeSliderDragExit:(UISlider *)sender {
}

- (IBAction)timeSliderUpInside:(UISlider *)sender {
    NSLog(@"timeSliderUpInside sender.value:%f",sender.value);
    _timeLabel.text = [NSString stringWithFormat:@"%.0f",sender.value];
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(updateOutInTimeValue:)]) {
        [self.delegate updateOutInTimeValue:sender.value];
    }
}
@end
