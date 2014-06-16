//
//  alarmVolumeCell.h
//  FuMiProduct
//
//  Created by Monster on 14-6-16.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alarmVolumeCellDelegate <NSObject>

-(void)updateVolumeValue:(NSUInteger)value;

@end

@interface alarmVolumeCell : UITableViewCell
{
    id<alarmVolumeCellDelegate>delegate;
}
@property(weak,nonatomic)id<alarmVolumeCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *label;


@property (weak, nonatomic) IBOutlet UISlider *sliderView;
- (IBAction)sliderValueChanged:(UISlider *)sender;
- (IBAction)sliderTouchUpInside:(UISlider *)sender;

-(void)setCellValue:(NSUInteger)value;
@end
