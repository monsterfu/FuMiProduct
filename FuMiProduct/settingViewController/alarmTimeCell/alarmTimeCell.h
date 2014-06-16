//
//  alarmTimeCell.h
//  FuMiProduct
//
//  Created by Monster on 14-6-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alarmTimeCellDelegate <NSObject>

-(void)updateTimeValue:(NSUInteger)value;

@end

@interface alarmTimeCell : UITableViewCell
{
    id<alarmTimeCellDelegate>delegate;
}
@property (weak, nonatomic)id<alarmTimeCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UISlider *slider;

- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)sliderTouchUpInside:(UISlider *)sender;
-(void)setCellValue:(NSUInteger)value;
@end
