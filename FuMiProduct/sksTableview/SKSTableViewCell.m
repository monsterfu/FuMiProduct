//
//  SKSTableViewCell.m
//  SKSTableView
//
//  Created by Sakkaras on 26/12/13.
//  Copyright (c) 2013 Sakkaras. All rights reserved.
//

#import "SKSTableViewCell.h"

@interface SKSTableViewCell ()

@end

@implementation SKSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setIsExpandable:NO];
        [self setIsExpanded:NO];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

static UIImage *_image = nil;
- (UIView *)expandableView
{
    if (!_image) {
        _image = [UIImage imageNamed:@"expandable.png"];
    }
    
    UIImageView *imageView = [[UIImageView alloc]init];
    CGRect frame = CGRectMake(0.0, 0.0, 30, 30);
    imageView.frame = frame;
    imageView.image = _image;
    
    return imageView;
}

- (void)setIsExpandable:(BOOL)isExpandable
{
    if (isExpandable){
        [self setAccessoryView:[self expandableView]];
    }
    _isExpandable = isExpandable;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
