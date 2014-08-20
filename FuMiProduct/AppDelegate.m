//
//  AppDelegate.m
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-1.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import "AppDelegate.h"
#import "ICETutorialController.h"

@implementation AppDelegate

-(void)fistUseViewShow
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Init the pages texts, and pictures.
    ICETutorialPage *layer1 = [[ICETutorialPage alloc] initWithSubTitle:@"离家设防"
                                                            description:@"离家设防介绍"
                                                            pictureName:@"firstUse1"];
    ICETutorialPage *layer2 = [[ICETutorialPage alloc] initWithSubTitle:@"视频通话、留言"
                                                            description:@"视频通话、留言视频通话、留言"
                                                            pictureName:@"firstUse2"];
    ICETutorialPage *layer3 = [[ICETutorialPage alloc] initWithSubTitle:@"门磁红外"
                                                            description:@"门磁红外门磁红外"
                                                            pictureName:@"firstUse3"];
    
    // Set the common style for SubTitles and Description (can be overrided on each page).
    ICETutorialLabelStyle *subStyle = [[ICETutorialLabelStyle alloc] init];
    [subStyle setFont:TUTORIAL_SUB_TITLE_FONT];
    [subStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [subStyle setLinesNumber:TUTORIAL_SUB_TITLE_LINES_NUMBER];
    [subStyle setOffset:TUTORIAL_SUB_TITLE_OFFSET];
    
    ICETutorialLabelStyle *descStyle = [[ICETutorialLabelStyle alloc] init];
    [descStyle setFont:TUTORIAL_DESC_FONT];
    [descStyle setTextColor:TUTORIAL_LABEL_TEXT_COLOR];
    [descStyle setLinesNumber:TUTORIAL_DESC_LINES_NUMBER];
    [descStyle setOffset:TUTORIAL_DESC_OFFSET];
    
    // Load into an array.
    NSArray *tutorialLayers = @[layer1,layer2,layer3];
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPhone"
                                                                      bundle:nil
                                                                    andPages:tutorialLayers];
    } else {
        self.viewController = [[ICETutorialController alloc] initWithNibName:@"ICETutorialController_iPad"
                                                                      bundle:nil
                                                                    andPages:tutorialLayers];
    }
    
    // Set the common styles, and start scrolling (auto scroll, and looping enabled by default)
    [self.viewController setCommonPageSubTitleStyle:subStyle];
    [self.viewController setCommonPageDescriptionStyle:descStyle];
    
    UIViewController* viewController = self.viewController;
    // Set button 1 action.
    [self.viewController setButton1Block:^(UIButton *button){
        NSLog(@"Button 1 pressed.");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        loginViewController* loginInViewController = [storyboard instantiateInitialViewController];
        [viewController presentViewController:loginInViewController animated:YES completion:^(void){
            [USER_DEFAULT setInteger:1 forKey:KEY_FIRST_USE];
            NSLog(@"[USER_DEFAULT boolForKey:KEY_FIRST_USE]:%ld",(long)[USER_DEFAULT integerForKey:KEY_FIRST_USE]);
            [USER_DEFAULT synchronize];
        }];
        }];
    
    // Set button 2 action, stop the scrolling.
    __unsafe_unretained typeof(self) weakSelf = self;
    [self.viewController setButton2Block:^(UIButton *button){
        NSLog(@"Button 2 pressed.");
        NSLog(@"Auto-scrolling stopped.");
        
        [weakSelf.viewController stopScrolling];
    }];
    
    // Run it.
    [self.viewController startScrolling];
    
    self.window.rootViewController = self.viewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSLog(@"[USER_DEFAULT boolForKey:KEY_FIRST_USE]:%ld",(long)[USER_DEFAULT integerForKey:KEY_FIRST_USE]);
    if (![USER_DEFAULT integerForKey:KEY_FIRST_USE]) {
        [self fistUseViewShow];
    }
    
    [self.window makeKeyAndVisible];
    
    //push notification
    
    [BPush setupChannel:launchOptions]; // 必须
    [BPush setDelegate:self]; // 必须。参数对象必须实现onMethod: response:方法，本示例中为self
    // [BPush setAccessToken:@"3.ad0c16fa2c6aa378f450f54adb08039.2592000.1367133742.282335-602025"];  // 可选。api key绑定时不需要，也可在其它时机调用
    [application registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert
     | UIRemoteNotificationTypeBadge
     | UIRemoteNotificationTypeSound];
    
    return YES;
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [BPush registerDeviceToken:deviceToken]; // 必须
    
    [BPush bindChannel]; // 必须。可以在其它时机调用，只有在该方法返回（通过onMethod:response:回调）绑定成功时，app才能接收到Push消息。一个app绑定成功至少一次即可（如果access token变更请重新绑定）。
}
- (void) onMethod:(NSString*)method response:(NSDictionary*)data
{
    if ([BPushRequestMethod_Bind isEqualToString:method])
    {
        NSDictionary* res = [[NSDictionary alloc] initWithDictionary:data];
        
        NSString *appid = [res valueForKey:BPushRequestAppIdKey];
        NSString *userid = [res valueForKey:BPushRequestUserIdKey];
        NSString *channelid = [res valueForKey:BPushRequestChannelIdKey];
        int returnCode = [[res valueForKey:BPushRequestErrorCodeKey] intValue];
        NSString *requestid = [res valueForKey:BPushRequestRequestIdKey];
        
        if (userid == nil) {
            [USER_DEFAULT removeObjectForKey:BPushRequestUserIdKey];
        }
        [USER_DEFAULT setObject:userid forKey:BPushRequestUserIdKey];
        [USER_DEFAULT synchronize];
    }
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    [BPush handleNotification:userInfo]; // 可选
    
    NSLog(@"Receive Notify: %@", [userInfo JSONString]);
    NSString *alert = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if (application.applicationState == UIApplicationStateActive) {
        // Nothing to do if applicationState is Inactive, the iOS already displayed an alert view.
        if (![alert isEqualToString:@"主机更新了状态"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"福米智能安防"
                                                                message:[NSString stringWithFormat:@"%@", alert]
                                                               delegate:self
                                                      cancelButtonTitle:@"确定"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
        
    }
    [application setApplicationIconBadgeNumber:0];
    
    [BPush handleNotification:userInfo];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_UpdateHostInfo object:nil];
//    self.viewController.textView.text = [self.viewController.textView.text stringByAppendingFormat:@"Receive notification:\n%@", [userInfo JSONString]];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_UpdateHostInfo object:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[NSNotificationCenter defaultCenter]postNotificationName:NSNotificationCenter_UpdateHostInfo object:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
