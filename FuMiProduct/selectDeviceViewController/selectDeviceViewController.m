//
//  selectDeviceViewController.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-10.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "selectDeviceViewController.h"

@interface selectDeviceViewController ()

@end

#define SELECTDEVICE_ACTION  @"selectDeviceAction"

@implementation selectDeviceViewController

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
    if ([segue.identifier isEqualToString:SELECTDEVICE_ACTION]) {
        
        
        loginViewController* _loginViewController = (loginViewController*)[segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        _loginViewController.hostLogoModel = [_hostDeviceArray objectAtIndex:[indexPath row]];
        
        [USER_DEFAULT removeObjectForKey:KEY_HOSTID];
        [USER_DEFAULT setObject:_loginViewController.hostLogoModel.hostid forKey:KEY_HOSTID];
        [USER_DEFAULT synchronize];
    }
}

#pragma mark - tableview Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _hostLogo = [_hostDeviceArray objectAtIndex:indexPath.row];
        
    [self performSegueWithIdentifier:SELECTDEVICE_ACTION sender:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _hostDeviceArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _deviceCell = [tableView dequeueReusableCellWithIdentifier:@"deviceCell"];
    _hostLogo = [_hostDeviceArray objectAtIndex:indexPath.row];
    _deviceCell.textLabel.text = _hostLogo.name;
    return _deviceCell;
}

- (IBAction)backButtonTouched:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
