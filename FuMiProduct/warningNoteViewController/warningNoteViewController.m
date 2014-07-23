//
//  warningNoteViewController.m
//  FuMiProduct
//
//  Created by Monster on 14-7-21.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "warningNoteViewController.h"

@interface warningNoteViewController ()

@end

@implementation warningNoteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _cnTime = [[ NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"] ;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3+_warningNote.alarmessageArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* _cell;
    if (indexPath.row == 0) {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"warningStartCell"];
        NSDate* startDate = [NSDate dateWithString:_warningNote.starttime];
        _cell.textLabel.text = [startDate descriptionWithLocale:_cnTime];
        return _cell;
    }else if(indexPath.row == 1)
    {
        _cell = [tableView dequeueReusableCellWithIdentifier:@"warningEndCell"];
        NSDate* startDate = [NSDate dateWithString:_warningNote.endtime];
        _cell.textLabel.text = [startDate descriptionWithLocale:_cnTime];
        return _cell;
    }else if(indexPath.row == 2)
    {
        _infoCell = [tableView dequeueReusableCellWithIdentifier:@"warningNoteInfoIdentifier"];
        _infoCell.textView.text = _warningNote.respinfo;
        return _infoCell;
    }else
    {
        _deviceInfoCell = [tableView dequeueReusableCellWithIdentifier:@"warningNoteDeviceInfoIdentifier"];
        alarmMessageModel* model = [_warningNote.alarmessageArray objectAtIndex:indexPath.row - 3];
        _deviceInfoCell.deviceName.text = model.name;
        _deviceInfoCell.Info.text = [NSString stringWithFormat:@"时间:%@,信息:%@",model.messages.time,model.messages.content];
        return _deviceInfoCell;
    }
}
@end
