//
//  synDeviceViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "synDeviceViewController.h"

@interface synDeviceViewController ()

@end


#define DEVICELIST_ACTION  @"deviceListAction"

@implementation synDeviceViewController

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
    _phoneNumField.delegate = self;
    if ([USER_DEFAULT objectForKey:KEY_USERNAME]) {
        _phoneNumField.text = [USER_DEFAULT objectForKey:KEY_USERNAME];
    }else{
        [_phoneNumField becomeFirstResponder];
    }
    
    _hostDeviceArray = [NSMutableArray array];
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
    if ([segue.identifier isEqualToString:DEVICELIST_ACTION]) {
        selectDeviceViewController* _selectViewController = (selectDeviceViewController*)[segue destinationViewController];
        _selectViewController.hostDeviceArray = _hostDeviceArray;
    }
}

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

- (IBAction)synButton:(UIButton *)sender {
    NSLog(@"loginTouched");
    
    NSString* telephoneNum = [_phoneNumField.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (![self isMobileNumber:telephoneNum]) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"请输入正确的手机号码" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    [_phoneNumField resignFirstResponder];
    
    [HttpRequest fetchHostRequest:telephoneNum seqno:[NSString randomStr] delegate:self finishSel:@selector(GetResult:) failSel:@selector(GetErr:)];
    
    [ProgressHUD show:@"获取主机信息中,请稍候"];
}

#pragma mark -
-(void)tap:(UITapGestureRecognizer*)sender
{
    [_phoneNumField resignFirstResponder];
}

#pragma mark http result
-(void) GetErr:(ASIHTTPRequest *)request
{
    [ProgressHUD showError:@"获取失败，请检查网络连接是否正常!"];
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
        _hostDeviceArray = [NSMutableArray array];
        
        _deviceListModel = [[deviceListModel alloc]initWithDictionary:dictionary hostArray:_hostDeviceArray];
        if ([_deviceListModel.respcode doubleValue] != respcode_Success) {
            [ProgressHUD showError:_deviceListModel.respinfo];
        }else{            
            //存手机号  主机编码
            [ProgressHUD dismiss];
            [USER_DEFAULT removeObjectForKey:KEY_USERNAME];
            [USER_DEFAULT setObject:_phoneNumField.text forKey:KEY_USERNAME];
            [USER_DEFAULT synchronize];
            
            [self performSegueWithIdentifier:DEVICELIST_ACTION sender:nil];
        }
    }else{
       [ProgressHUD showError:@"获取失败，请检查网络连接是否正常!"];
    }
    
    
}

#pragma mark  -textField delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _phoneNumField) {
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
    if (textField == _phoneNumField) {
        if (textField.text.length != 13) {
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提醒" message:@"输入的手机号位数不对" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [alertView show];
            return NO;
        }
        [self synButton:nil];
        return YES;
    }
    return YES;
}
@end
