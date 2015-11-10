//
//  LoginViewController.h
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Google/SignIn.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate, GIDSignInUIDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *login;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *btnSignInWithGoogle;
@property (weak, nonatomic) IBOutlet UIButton *btnSignInWithFacebook;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;


- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)backgroundTap:(id)sender;



@end

