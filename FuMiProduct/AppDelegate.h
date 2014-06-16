//
//  AppDelegate.h
//  FuMiProduct
//
//  Created by 符鑫 on 14-6-1.
//  Copyright (c) 2014年 Monster. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@class ICETutorialController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ICETutorialController *viewController;
@property (strong, nonatomic) loginViewController* loginInViewController;
@end
