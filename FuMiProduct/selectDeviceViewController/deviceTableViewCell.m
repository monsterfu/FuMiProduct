//
//  deviceTableViewCell.m
//  FuMiProduct
//
//  Created by Monster on 14-6-11.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "deviceTableViewCell.h"

@implementation deviceTableViewCell

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

@end
