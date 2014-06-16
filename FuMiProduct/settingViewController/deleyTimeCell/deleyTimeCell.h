//
//  deleyTimeCell.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol deleyTimeCellDelegate <NSObject>

-(void)updateOutInTimeValue:(NSUInteger)value;

@end


@interface deleyTimeCell : UITableViewCell
{
    id<deleyTimeCellDelegate>delegate;
}
@property (weak, nonatomic) id<deleyTimeCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UISlider *timerSlier;


- (IBAction)timeSlider:(UISlider *)sender;
- (IBAction)timeSliderDragExit:(UISlider *)sender;
- (IBAction)timeSliderUpInside:(UISlider *)sender;
@end
