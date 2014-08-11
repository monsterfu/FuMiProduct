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
    _cnTime = [[ NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    _sizeArray = [NSMutableArray array];
    
    UIView* footView = [UIView new];
    [footView setBackgroundColor:[UIColor clearColor]];
    [_tableView setTableFooterView:footView];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row  < 2) {
        return 49;
    }else if(indexPath.row == 2){
        return 50;
        CGSize size = [_warningNote.respinfo sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT*2) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height;
    }else{
        
        alarmMessageModel* model = [_warningNote.alarmessageArray objectAtIndex:indexPath.row - 3];
        NSString* str = [NSString stringWithFormat:@"时间:%@,信息:%@",model.time,model.content];
        
        CGSize size = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(DEVICE_WIDTH, DEVICE_HEIGHT*2) lineBreakMode:NSLineBreakByWordWrapping];
        return size.height + 60;
    }
}
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
        if (_warningNote.alarmessageArray.count == 0) {
            _infoCell.textView.text = @"暂无报警信息";
        }else{
            _infoCell.textView.text = _warningNote.respinfo;
        }
        return _infoCell;
    }else
    {
        _deviceInfoCell = [tableView dequeueReusableCellWithIdentifier:@"warningNoteDeviceInfoIdentifier" forIndexPath:indexPath];
        alarmMessageModel* model = [_warningNote.alarmessageArray objectAtIndex:indexPath.row - 3];
        _deviceInfoCell.deviceName.text = model.name;
        _deviceInfoCell.Info.text = [NSString stringWithFormat:@"时间:%@,信息:%@",model.time,model.content];
        return _deviceInfoCell;
    }
}
- (IBAction)backButtonTouch:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
