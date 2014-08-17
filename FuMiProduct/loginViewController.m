//
//  loginViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-1.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "loginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "mainViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

#define deviceId @"821227766539089"
#define LOGININ_ACTION @"loginActonExt"
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _userNameTextField.delegate = self;
    _passWordTextField.delegate = self;
    
    if ([USER_DEFAULT objectForKey:KEY_USERNAME]) {
        _userNameTextField.text = [USER_DEFAULT objectForKey:KEY_USERNAME];
    }
    _inputTextField.text = _hostLogoModel.name;
//    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    [self.view addGestureRecognizer:tapGesture];
    
    [_passWordTextField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:LOGININ_ACTION]) {
        mainViewController* _mainViewController = (mainViewController*)[segue destinationViewController];
        _mainViewController.hostDeviceArray = _hostDeviceArray;
        _mainViewController.rfidDeviceArray = _rfidDeviceArray;
        _mainViewController.alarmDeviceArray = _alarmDeviceArray;
        _mainViewController.hostLogoModel = _hostLogoModel;
        _mainViewController.alarmPhoneArray = _alarmPhoneArray;
    }
}
#pragma mark - 
-(void)tap:(UITapGestureRecognizer*)sender
{
    [_passWordTextField resignFirstResponder];
}
#pragma mark -
- (IBAction)userNameFieldEditingEnd:(UITextField *)sender {
    NSLog(@"userNameFieldEditingEnd");
}

- (IBAction)passWordFieldEditingEnd:(UITextField *)sender {
    NSLog(@"passWordFieldEditingEnd");
}

- (IBAction)loginTouched:(UIButton *)sender {
    NSLog(@"loginTouched");
    
    NSString* telephoneNum = [_userNameTextField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (![self isMobileNumber:telephoneNum]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if (_passWordTextField.text.length < 4) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"密码不能少于4位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [_userNameTextField resignFirstResponder];
    [_passWordTextField resignFirstResponder];
    
    [HttpRequest LoginRequest:telephoneNum password:_passWordTextField.text hostId:_hostLogoModel.hostid seqno:[NSString randomStr] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    [ProgressHUD show:@"登录中,请稍候"];
}

#pragma mark http result
-(void) GetErr:(ASIHTTPRequest *)request
{
    [ProgressHUD showError:@"登陆失败，请检查网络连接是否正常!"];
}
-(void) GetResult:(ASIHTTPRequest *)request
{
    [USER_DEFAULT removeObjectForKey:KEY_USERNAME];
    [USER_DEFAULT setObject:_userNameTextField.text forKey:KEY_USERNAME];
    [USER_DEFAULT setObject:_passWordTextField.text forKey:KEY_PASSWORD];
    [USER_DEFAULT synchronize];
    
    
    NSData *responseData = [request responseData];
//    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"pageSource:%@",pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSLog(@"dic is %@",dictionary);
    if(dictionary!=nil){
        
        _hostDeviceArray = [NSMutableArray array];
        _alarmDeviceArray = [NSMutableArray array];
        _rfidDeviceArray = [NSMutableArray array];
        _alarmPhoneArray = [NSMutableArray array];
        
        
        _loginModel = [[loginModel alloc]initWithDictionary:dictionary hostArray:_hostDeviceArray alarmDeviceArray:_alarmDeviceArray rfidDeviceArray:_rfidDeviceArray alarmPhoneArray:_alarmPhoneArray];
        if ([_loginModel.respcode doubleValue] != respcode_Success) {
            [ProgressHUD showError:_loginModel.respinfo];
        }else{
            [ProgressHUD dismiss];
            [USER_DEFAULT removeObjectForKey:KEY_PASSWORD];
            [USER_DEFAULT setObject:_passWordTextField.text forKey:KEY_PASSWORD];
            [USER_DEFAULT synchronize];
            [self performSegueWithIdentifier:LOGININ_ACTION sender:nil];
        }
    }else{
        [ProgressHUD showError:@"登陆失败，请检查网络连接是否正常!"];
    }
    
}
-(void) GetsynchrDataResult:(ASIHTTPRequest *)request
{
    NSData *responseData = [request responseData];
    NSString*pageSource = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"responseData is %@ pageSource:%@",responseData,pageSource);
    NSError *error;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:[pageSource dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    NSLog(@"dic is %@",dictionary);
    if(dictionary!=nil){
        [ProgressHUD dismiss];
        [self performSegueWithIdentifier:@"loginActonExt" sender:nil];
        
        _hostDeviceArray = [NSMutableArray array];
        _alarmDeviceArray = [NSMutableArray array];
        _rfidDeviceArray = [NSMutableArray array];
        
        _synchrDataModel = [[synchrDataModel alloc]initWithDictionary:dictionary hostArray:_hostDeviceArray alarmDeviceArray:_alarmDeviceArray rfidDeviceArray:_rfidDeviceArray];
    }
}
#pragma mark viewControll eg

- (BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
#pragma mark  -textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _userNameTextField) {
        NSString *validRegEx =@"^[0-9]*$";
        NSPredicate *regExPredicate =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEx];
        BOOL myStringMatchesRegEx = [regExPredicate evaluateWithObject:string];
        if (myStringMatchesRegEx)
        {
            if (range.location == 3 || range.location == 8) {
                if (![string isEqualToString:@""]) {
                    textField.text = [NSString stringWithFormat:@"%@-",textField.text];
                }
            }
            
            if (range.location >= 13) {
                return NO;
            }
            return YES;
        }
        else
            return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userNameTextField) {
        if (textField.text.length != 13) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"输入的手机号位数不对" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            return NO;
        }
        [_passWordTextField becomeFirstResponder];
        return YES;
    }else{
        [self loginTouched:nil];
    }
    return YES;
}
- (IBAction)backButtonTouched:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
