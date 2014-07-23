//
//  mainViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-2.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "mainViewController.h"
#import "settingViewController.h"

//18676686204   123456

@interface mainViewController ()

@end

#define SETTINGACTION  @"settingAction"
#define WARNINGNOTE_Action  @"warningNoteIdentifier"
@implementation mainViewController

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
    
    _systemBastion.arrange = CustomSwitchArrangeONLeftOFFRight;
    _systemBastion.onImage = [UIImage imageNamed:@"on.png"];
    _systemBastion.offImage = [UIImage imageNamed:@"off.png"];
    _systemBastion.status = CustomSwitchStatusOff;
    _systemBastion.delegate = self;
    
    _homeBastion.arrange = CustomSwitchArrangeONLeftOFFRight;
    _homeBastion.onImage = [UIImage imageNamed:@"on.png"];
    _homeBastion.offImage = [UIImage imageNamed:@"off.png"];
    _homeBastion.status = CustomSwitchStatusOff;
    _homeBastion.delegate = self;
    
    _systemCancelBastion.arrange = CustomSwitchArrangeONLeftOFFRight;
    _systemCancelBastion.onImage = [UIImage imageNamed:@"on.png"];
    _systemCancelBastion.offImage = [UIImage imageNamed:@"off.png"];
    _systemCancelBastion.status = CustomSwitchStatusOff;
    _systemCancelBastion.delegate = self;
    
    //set
    _telephoneName = [[USER_DEFAULT objectForKey:KEY_USERNAME] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([_hostDeviceArray count]) {
        _hostPropertyModel = [_hostDeviceArray objectAtIndex:0];
        [self changeWorkStatus:_hostPropertyModel.workstatus];
    }
    
    _enterPassWordGapIsDone = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeWorkStatus:(NSString*)status
{
    if ([status isEqualToString:HostWorkSts_LJSF]) {
        [_statusButton setImage:[UIImage imageNamed:@"leaveHome.png"] forState:UIControlStateNormal];
        [_statusButton setTitle:@"离家设防" forState:UIControlStateNormal];
        [_systemBastion changeStatus:CustomSwitchStatusOn];
        [_systemCancelBastion changeStatus:CustomSwitchStatusOff];
        [_homeBastion changeStatus:CustomSwitchStatusOff];
    }else if ([status isEqualToString:HostWorkSts_ZJSF]) {
        [_statusButton setImage:[UIImage imageNamed:@"homeMid.png"] forState:UIControlStateNormal];
        [_statusButton setTitle:@"在家设防" forState:UIControlStateNormal];
        [_systemBastion changeStatus:CustomSwitchStatusOff];
        [_systemCancelBastion changeStatus:CustomSwitchStatusOff];
        [_homeBastion changeStatus:CustomSwitchStatusOn];
    }else{
        [_statusButton setImage:[UIImage imageNamed:@"chefangMid.png"] forState:UIControlStateNormal];
        [_statusButton setTitle:@"撤防" forState:UIControlStateNormal];
        [_systemBastion changeStatus:CustomSwitchStatusOff];
        [_systemCancelBastion changeStatus:CustomSwitchStatusOn];
        [_homeBastion changeStatus:CustomSwitchStatusOff];
    }
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:SETTINGACTION]) {
        settingViewController* _settingViewController = (settingViewController*)[segue destinationViewController];
        _settingViewController.hostDeviceArray = _hostDeviceArray;
        _settingViewController.rfidDeviceArray = _rfidDeviceArray;
        _settingViewController.alarmDeviceArray = _alarmDeviceArray;
        _settingViewController.hostPropertyModel = _hostPropertyModel;
    }else if([segue.identifier isEqualToString:WARNINGNOTE_Action]){
        warningNoteViewController* _warningNoteViewController = (warningNoteViewController*)[segue destinationViewController];
        _warningNoteViewController.warningNote = _warningNoteModel;
    }
    
}

#pragma mark http result
-(void) GetErr:(ASIHTTPRequest *)request
{
    if (request.tag == TAG_LJSF){
        [ProgressHUD showError:@"离家设防失败，请重试！"];
        _systemBastion.status = CustomSwitchStatusOff;
    }else if (request.tag == TAG_ZJSF){
        [ProgressHUD showError:@"在家设防失败，请重试！"];
        _homeBastion.status = CustomSwitchStatusOff;
    }else if (request.tag == TAG_CF){
        [ProgressHUD showError:@"撤防失败，请重试！"];
        _systemCancelBastion.status = CustomSwitchStatusOff;
    }
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"responseData is %@",pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    NSLog(@"dic is %@",dictionary);
    if (request.tag == TAG_LJSF) {
        
        if(dictionary!=nil){
            _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
            if ([_commRespondModel.respcode intValue] != respcode_Success) {
                [ProgressHUD showError:_commRespondModel.respinfo];
                _systemBastion.status = CustomSwitchStatusOff;
            }else{
                [ProgressHUD showSuccess:@"离家设防成功！"];
                _homeBastion.status = CustomSwitchStatusOff;
                _systemCancelBastion.status = CustomSwitchStatusOff;
                [self changeWorkStatus:HostWorkSts_LJSF];
            }
        }else{
            [ProgressHUD showError:@"离家设防失败，请重试！"];
            _systemBastion.status = CustomSwitchStatusOff;
        }
    }else if (request.tag == TAG_ZJSF){
        if(dictionary!=nil){
            _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
            if ([_commRespondModel.respcode intValue] != respcode_Success) {
                _homeBastion.status = CustomSwitchStatusOff;
                [ProgressHUD showError:_commRespondModel.respinfo];
            }else{
                [ProgressHUD showSuccess:@"在家设防成功！"];
                _systemBastion.status = CustomSwitchStatusOff;
                _systemCancelBastion.status = CustomSwitchStatusOff;
                [self changeWorkStatus:HostWorkSts_ZJSF];
            }
        }else{
            _homeBastion.status = CustomSwitchStatusOff;
            [ProgressHUD showError:@"在家设防失败，请重试！"];
        }
    }else if (request.tag == TAG_CF){
        if(dictionary!=nil){
            _commRespondModel = [[commonRespondModel alloc]initWithDictionary:dictionary];
            if ([_commRespondModel.respcode intValue]!= respcode_Success) {
                [ProgressHUD showError:_commRespondModel.respinfo];
                _systemCancelBastion.status = CustomSwitchStatusOff;
            }else{
                [ProgressHUD showSuccess:@"撤防成功！"];
                _systemBastion.status = CustomSwitchStatusOff;
                _homeBastion.status = CustomSwitchStatusOff;
                [self changeWorkStatus:HostWorkSts_CF];
            }
        }else{
            [ProgressHUD showError:@"撤防失败，请重试！"];
            _systemCancelBastion.status = CustomSwitchStatusOff;
        }
    }else if (request.tag == TAG_WARNINGNOTE){
        if(dictionary!=nil){
            [ProgressHUD showSuccess:@"获取报警日志成功！"];
            _warningNoteModel = [[warningNoteModel alloc]initWithDictionary:dictionary];
            [self performSegueWithIdentifier:@"warningNoteIdentifier" sender:nil];
        }else{
            [ProgressHUD showError:@"获取报警日志失败！"];
        }
    }
    
    
    
}

#pragma mark CustomSwitchDelegate

-(void)customSwitch:(CustomSwitch*)customSwitch SetStatus:(CustomSwitchStatus)status
{
    if (customSwitch == _systemBastion) {
        if (status == CustomSwitchStatusOn) {
            [ProgressHUD show:@"离家设防中，请稍候……"];
            [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:@"福米" email:@"" question:@"" answer:@"" workstatus:HostWorkSts_LJSF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_LJSF];
        }
        
    }else if(customSwitch == _homeBastion){
        if (status == CustomSwitchStatusOn) {
            [ProgressHUD show:@"在家设防中，请稍候……"];
            [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:_hostLogoModel.name email:@"" question:@"" answer:@"" workstatus:HostWorkSts_ZJSF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_ZJSF];
        }
        
    }else if(customSwitch == _systemCancelBastion){
        if (status == CustomSwitchStatusOn) {
            
            BOOL passwordOpen = [USER_DEFAULT boolForKey:CHEFANG_PASSWORD_OPEN];
            if (passwordOpen) {
                if (!_enterPassWordGapIsDone) {
                    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您已连续输错撤防密码三次，请等待5分钟后再次输入" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
                    [alertView show];
                    _systemCancelBastion.status = CustomSwitchStatusOff;
                    return;
                }
                PAPasscodeViewController *passcodeViewController = [[PAPasscodeViewController alloc] initForAction:PasscodeActionEnter];
                passcodeViewController.delegate = self;
                passcodeViewController.passcode =  [USER_DEFAULT stringForKey:KEY_PASSWORD];
                passcodeViewController.simple = CustomSwitchStatusOff;
                [self presentViewController:passcodeViewController animated:YES completion:nil];
            }else{
                [ProgressHUD show:@"撤防中，请稍候……"];
                [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:_hostLogoModel.name email:@"" question:@"" answer:@"" workstatus:HostWorkSts_CF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_CF];
            }
        }
    }
}

#pragma mark ButtonAction

- (IBAction)backButtonTouched:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)bastionTouched:(UIButton *)sender {
//    [ProgressHUD show:@"离家设防中，请稍后……"];
//    [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:_hostLogoModel.name email:@"" question:@"" answer:@"" workstatus:HostWorkSts_LJSF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_LJSF];
}

- (IBAction)warningLogTouched:(UIButton *)sender {
    [ProgressHUD show:@"获取报警日志中，请稍候……"];
    NSDate* earlyDate = [NSDate convertDateToLocalTime:[NSDate dateWithTimeIntervalSinceNow:-1*365*24*60*60]];
    NSDate* todatDate = [NSDate convertDateToLocalTime:[NSDate dateWithTimeIntervalSinceNow:-10]];
    [HttpRequest warningNoteRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] begintime:[NSString dateFormater:earlyDate] endtime:[NSString dateFormater:todatDate] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
//    [self performSegueWithIdentifier:@"warningNoteIdentifier" sender:nil];
}

- (IBAction)videoTelephoneTouched:(UIButton *)sender {
}

- (IBAction)messageTouched:(UIButton *)sender {
}

- (IBAction)customerServiceTouched:(UIButton *)sender {
}

-(void)changeEnterPasswordSign
{
    _enterPassWordGapIsDone = YES;
}
#pragma mark - PAPasscodeViewControllerDelegate

- (void)PAPasscodeViewControllerDidCancel:(PAPasscodeViewController *)controller {
    _systemCancelBastion.status = CustomSwitchStatusOff;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)PAPasscodeViewControllerDidEnterPasscode:(PAPasscodeViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:^() {
        
        [ProgressHUD show:@"撤防中，请稍候……"];
        [HttpRequest proportySetRequest:_telephoneName host:_hostLogoModel.hostid seqno:[NSString randomStr] name:_hostLogoModel.name email:@"" question:@"" answer:@"" workstatus:HostWorkSts_CF rspdelay:@"" almvolume:@"" alarmtime:@"" retpwdflag:@"" onekeyphone:@"" address:@"" delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:) tag:TAG_CF];
        
    }];
}
- (void)PAPasscodeViewController:(PAPasscodeViewController *)controller didFailToEnterPasscode:(NSInteger)attempts
{
    if (attempts  == 3) {
        _systemCancelBastion.status = CustomSwitchStatusOff;
        _enterPassWordGapIsDone = NO;
        
        _enterPasswordTimer = [NSTimer timerWithTimeInterval:120 target:self selector:@selector(changeEnterPasswordSign) userInfo:nil repeats:NO];
        [self dismissViewControllerAnimated:YES completion:nil];
        
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您已连续输错撤防密码三次，请等待2分钟后再次输入" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}
@end
