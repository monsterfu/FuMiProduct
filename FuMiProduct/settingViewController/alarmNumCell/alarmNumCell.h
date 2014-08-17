//
//  alarmNumCell.h
//  FuMiProduct
//
//  Created by Monster on 14-6-12.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"
#import "alarmTelephoneModel.h"

@protocol alarmNumCellDelegate <NSObject>

-(void)alarmNumCellupdatePhoneNum:(alarmTelephoneModel*)alarmTeleModel num:(NSUInteger)index;

@end

@interface alarmNumCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic,assign)id<alarmNumCellDelegate>delegate;
@property (nonatomic, strong)alarmTelephoneModel* alarmTeleModel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@end
