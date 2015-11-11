//
//  AppDelegate.h
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate, GIDSignInDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

