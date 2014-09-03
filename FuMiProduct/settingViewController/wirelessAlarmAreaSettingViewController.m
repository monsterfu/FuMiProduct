//
//  wirelessAlarmAreaSettingViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "wirelessAlarmAreaSettingViewController.h"

@interface wirelessAlarmAreaSettingViewController ()

@end

@implementation wirelessAlarmAreaSettingViewController

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
    _nameArray = @[@"普通防区",@"在家防区",@"24小时防区",@"独立防区"];
    
    _tableView.SKSTableViewDelegate = self;
    _tableView.shouldExpandOnlyOneCell = YES;
    
    //去掉TABLEVIEW 多余分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
    
    _deviceTypeDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"无线门磁",@"01",@"无线烟感",@"02",@"无线红外人体感应",@"03",@"无线红外广角幕帘",@"04",@"无线红外栅栏",@"05",@"无线水侵",@"06",@"无线煤气感应",@"07",@"无线遥控",@"08",@"无线雾霾",@"09",nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of a, nilny resources that can be recreated.
}

-(void)setAlarmDeviceArray:(NSMutableArray *)alarmDeviceArray
{
    _alarmDeviceArray = alarmDeviceArray;
    
    _commonFQArray = [NSMutableArray array];
    _homeFQArray = [NSMutableArray array];
    _allDayFQArray  = [NSMutableArray array];
    _singonlArray = [NSMutableArray array];
    
    for (wirelessAlarmDeviceModel* model in _alarmDeviceArray) {
        if ([model.status isEqualToString:AlarmDeviceSts_2]) {
            [_commonFQArray addObject:model];
        }else if([model.status isEqualToString:AlarmDeviceSts_3]) {
            [_allDayFQArray addObject:model];
        }else if([model.status isEqualToString:AlarmDeviceSts_4]) {
            [_homeFQArray addObject:model];
        }else if([model.status isEqualToString:AlarmDeviceSts_5]){
            [_singonlArray addObject:model];
        }
    }
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

- (IBAction)backButtonTouched:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - TableView Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_nameArray count];
}

- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            return [_commonFQArray count];
        }
            break;
            
        case 1:
        {
            return [_homeFQArray count];
        }
            break;
            
        case 2:
        {
            return [_allDayFQArray count];
        }
            break;
        case 3:
        {
            return [_singonlArray count];
        }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    _deviceCell = [tableView dequeueReusableCellWithIdentifier:@"wirelessAlarmDeviceIdentifier"];
    if (indexPath.row == 0) {
        _deviceCell.deviceModel = [_commonFQArray objectAtIndex:indexPath.subRow-1];
    }else if (indexPath.row == 1) {
        _deviceCell.deviceModel = [_homeFQArray objectAtIndex:indexPath.subRow-1];
    }else if (indexPath.row == 2) {
        _deviceCell.deviceModel = [_allDayFQArray objectAtIndex:indexPath.subRow-1];
    }else if (indexPath.row == 3) {
        _deviceCell.deviceModel = [_singonlArray objectAtIndex:indexPath.subRow-1];
    }
    _deviceCell.nameLabel.text = [_deviceTypeDic objectForKey:_deviceCell.deviceModel.type];
    _deviceCell.delegate = self;
    _deviceCell.tag = indexPath.row;
    return _deviceCell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 58.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKSTableViewCell* settingCell = [tableView dequeueReusableCellWithIdentifier:@"settingMainCell"];
    
    settingCell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
    settingCell.textLabel.textColor = [UIColor hexStringToColor:@"#00735A"];
    
    switch (indexPath.row) {
        case 0:
        {
            if ([_commonFQArray count]) {
                settingCell.isExpandable = YES;
            }else{
                settingCell.isExpandable = NO;
            }
            
        }
            break;
            
        case 1:
        {
            if ([_homeFQArray count]) {
                settingCell.isExpandable = YES;
            }else
                settingCell.isExpandable = NO;
        }
            break;
            
        case 2:
        {
            if ([_allDayFQArray count]) {
                settingCell.isExpandable = YES;
            }else
                settingCell.isExpandable = NO;
        }
            break;
        case 3:
        {
            if ([_singonlArray count]) {
                settingCell.isExpandable = YES;
            }else
                settingCell.isExpandable = NO;
        }
            break;
        default:
            settingCell.isExpandable = NO;
            break;
    }
    
    return settingCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelectRowAtIndexPath:%d",indexPath.row);
}

#pragma mark -wirelessAlarmDeviceCellDelegate
-(void)wirelessAlarmDeviceSet:(wirelessAlarmDeviceModel *)deviceModel num:(NSUInteger)tag
{
    [_alarmDeviceArray removeObjectAtIndex:tag];
    [_alarmDeviceArray insertObject:deviceModel atIndex:tag];
    
    [HttpRequest wirelessAlarmDeviceSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] wirelessAlarmDeviceArray:_alarmDeviceArray delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    [HttpRequest wirelessAlarmDeviceSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] wirelessAlarmDevice:_deviceModel delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];

}

#pragma mark -http result

-(void) GetErr:(ASIHTTPRequest *)request
{
    [ProgressHUD showError:@"修改报警设备名失败"];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    //    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"pageSource:%@",pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSLog(@"dic is %@",dictionary);
    if(dictionary!=nil){
        _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
        if ([_commRespondModel.respcode intValue]!= respcode_Success) {
            [ProgressHUD showError:_commRespondModel.respinfo];
        }else{
            [ProgressHUD showSuccess:@"修改报警设备名成功!"];
        }
    }else{
        [ProgressHUD showError:_commRespondModel.respinfo];
    }
}
@end
