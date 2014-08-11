//
//  settingViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "settingViewController.h"

@interface settingViewController ()

@end

#define WIRELESSALARMACTION  @"wirelessAlarmAreaAction"
#define ALARMPHONENUMACTION  @"alarmPhoneSetAction"
#define FUMIKEFUACTION       @"fumiKFIAction"

@implementation settingViewController

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
    _nameArray = @[@"RFID设置",@"无线报警防区的定义",@"SOS报警电话号码设置",@"报警音量和时长设置",@"出入时延设置",@"独立防区时延设置",@"自动布防和撤防设置",@"撤防密码开关",@"用户反馈建议"];
    
    _tableView.SKSTableViewDelegate = self;
    _tableView.shouldExpandOnlyOneCell = YES;
    
    //去掉TABLEVIEW 多余分割线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:WIRELESSALARMACTION]) {
        wirelessAlarmAreaSettingViewController* _ViewController = (wirelessAlarmAreaSettingViewController*)[segue destinationViewController];
        _ViewController.alarmDeviceArray = _alarmDeviceArray;
    }
    
}


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
            return [_rfidDeviceArray count];
        }
            break;
            
        case 1:
        {
            return 1;
        }
            break;
            
        case 2:
        {
            return 5;
        }
            break;
            
        case 3:
        {
            return 2;
        }
            break;
            
        case 4:
        {
            return 1;
        }
            break;
            
        case 5:
        {
            return 1;
        }
            break;
            
        case 6:
        {
            return 1;
        }
            break;
        case 7:
        {
            return 1;
        }
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(SKSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        _rfidDeviceCell =[tableView dequeueReusableCellWithIdentifier:@"deviceIdentifier"];
        _rfidDeviceCell.rfidModel = [_rfidDeviceArray objectAtIndex:indexPath.subRow-1];
        _rfidDeviceCell.tag = indexPath.subRow-1;
        _rfidDeviceCell.delegate = self;
        return _rfidDeviceCell;
    }else if(indexPath.row == 2){
        _alarmNumCell= [tableView dequeueReusableCellWithIdentifier:@"alarmNumIdentifier"];
        return _alarmNumCell;
    }else if(indexPath.row == 3){
        if (indexPath.subRow == 1) {
            _alarmVolumeCell = [tableView dequeueReusableCellWithIdentifier:@"alarmVolumeIdentifier"];
            [_alarmVolumeCell setCellValue:[_hostPropertyModel.almvolume integerValue]];
            _alarmVolumeCell.delegate = self;
            return _alarmVolumeCell;
        }else{
            _alarmTimeCell = [tableView dequeueReusableCellWithIdentifier:@"alarmTimeIdentifier"];
            [_alarmTimeCell setCellValue:[_hostPropertyModel.alarmtime integerValue]];
            _alarmTimeCell.delegate = self;
            return _alarmTimeCell;
        }
    }else if(indexPath.row == 4||indexPath.row == 5) {
        _deleyTimeCell = [tableView dequeueReusableCellWithIdentifier:@"delayTimeCellIdentifier"];
        _deleyTimeCell.delegate = self;
        return _deleyTimeCell;
    }else if(indexPath.row == 6){
        UITableViewCell* settingCell = [tableView dequeueReusableCellWithIdentifier:@"settingMainCell"];
        settingCell.textLabel.text = @"暂未开通，后续版本升级中";
        settingCell.textLabel.textColor = [UIColor hexStringToColor:@"#00735A"];
        return settingCell;
    }else if(indexPath.row ==7) {
        _passwordSwitchCell = [tableView dequeueReusableCellWithIdentifier:@"passwordSwitchIdentifier"];
        _passwordSwitchCell.delegate = self;
        [_passwordSwitchCell setSwitchUI:[USER_DEFAULT boolForKey:CHEFANG_PASSWORD_OPEN]];
        return _passwordSwitchCell;
    }else{
        UITableViewCell* settingCell = [tableView dequeueReusableCellWithIdentifier:@"settingMainCell"];
        settingCell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
        settingCell.textLabel.textColor = [UIColor hexStringToColor:@"#00735A"];
        return settingCell;
    }
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
    settingCell.selectionStyle = UITableViewCellSelectionStyleGray;
    switch (indexPath.row) {
        case 0:
        {
            if ([_rfidDeviceArray count]) {
                settingCell.isExpandable = YES;
            }else{
                settingCell.isExpandable = NO;
            }
            
        }
            break;
            
        case 1:
        {
            settingCell.isExpandable = NO;
            settingCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
            
        case 2:
        {
            settingCell.isExpandable = YES;
        }
            break;
            
        case 3:
        {
            settingCell.isExpandable = YES;
        }
            break;
            
        case 4:
        {
            settingCell.isExpandable = YES;
        }
            break;
            
        case 5:
        {
            settingCell.isExpandable = YES;
        }
            break;
            
        case 6:
        {
            settingCell.isExpandable = YES;
        }
            break;
        case 7:
        {
            settingCell.isExpandable = YES;
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
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:WIRELESSALARMACTION sender:nil];
    }else if(indexPath.row == 2){
        //[self performSegueWithIdentifier:ALARMPHONENUMACTION sender:nil];
    }else if(indexPath.row == 9)
        [self performSegueWithIdentifier:FUMIKEFUACTION sender:nil];
    
}
#pragma mark - rfidDeviceCellDelegate
-(void)rfidSet:(rfidDeviceModel*)model num:(NSUInteger)tag
{
    [_rfidDeviceArray removeObjectAtIndex:tag];
    [_rfidDeviceArray insertObject:model atIndex:tag];
    
    
    [HttpRequest rfidSetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] rfidDeviceArray:_rfidDeviceArray delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
}
#pragma mark -alarmTimeCellDelegate

-(void)updateTimeValue:(NSUInteger)value
{
    [ProgressHUD show:@"修改报警时长中，请稍候"];
    [HttpRequest proportySetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] name:@"" email:@"" question:@"" answer:@"" workstatus:@"" rspdelay:@"" almvolume:@"" alarmtime:[NSString stringWithFormat:@"%d",value] retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_ALARMTIME];
}
#pragma mark -alarmVolumeCellDelegate

-(void)updateVolumeValue:(NSUInteger)value
{
    [ProgressHUD show:@"修改报警音量中，请稍候"];
    [HttpRequest proportySetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] name:@"" email:@"" question:@"" answer:@"" workstatus:@"" rspdelay:@"" almvolume:[NSString stringWithFormat:@"%d",value] alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_ALARMTIME];
}
#pragma mark - deleyTimeCellDelegate
-(void)updateOutInTimeValue:(NSUInteger)value
{
    [ProgressHUD show:@"修改出入时延中，请稍候"];
    [HttpRequest proportySetRequest:[NSString userName] host:[NSString hostId] seqno:[NSString randomStr] name:@"" email:@"" question:@"" answer:@"" workstatus:@"" rspdelay:[NSString stringWithFormat:@"%d",value] almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_OUTIN_DELAYTIME];
}
#pragma mark - passwordSwitchCellDelegate
-(void)openPassword:(BOOL)open
{
    [USER_DEFAULT removeObjectForKey:CHEFANG_PASSWORD_OPEN];
    [USER_DEFAULT setBool:open forKey:CHEFANG_PASSWORD_OPEN];
    [USER_DEFAULT synchronize];
}

#pragma mark -http result

-(void) GetErr:(ASIHTTPRequest *)request
{
    [ProgressHUD showError:@"修改报警设备名失败"];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"responseData is %@",pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSLog(@"dic is %@",dictionary);
    
    if(dictionary!=nil){
        _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
        if ([_commRespondModel.respcode intValue] != respcode_Success) {
            [ProgressHUD showError:_commRespondModel.respinfo];
        }else{
            if (request.tag == TAG_ALARMTIME){
                [ProgressHUD showSuccess:@"报警时长设置成功！"];
            }else if (request.tag == TAG_ALARMVOLUME){
                [ProgressHUD showSuccess:@"报警音量设置成功！"];
            }else if (request.tag == TAG_OUTIN_DELAYTIME){
                [ProgressHUD showSuccess:@"出入时延设置成功！"];
            }
        }
    }else{
        if (request.tag == TAG_ALARMTIME){
            [ProgressHUD showError:@"报警时长设置失败，请重试！"];
        }else if (request.tag == TAG_ALARMVOLUME){
            [ProgressHUD showError:@"报警音量设置失败，请重试！"];
        }else if (request.tag == TAG_OUTIN_DELAYTIME){
            [ProgressHUD showError:@"出入时延设置失败，请重试！"];
        }
    }
    
}

@end
