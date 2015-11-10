//
//  LoginViewController.m
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "LoginViewController.h"
#import "HttpApiHelper.h"
#import "SimpleKeychain.h"
#import "Constants.h"
#import "TabHomeViewController.h"



@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [GIDSignIn sharedInstance].uiDelegate = self;
    
    [self.navigationController setNavigationBarHidden:YES];
    [self setDisplayingSettingsForButtonsAndTextFields];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginClicked:(id)sender {
    HttpApiHelper *httpClient = [HttpApiHelper httpClient];
    [httpClient loginWithUserName:self.login.text
                         password:self.password.text
                          success:^(AFHTTPRequestOperation *task, id responseObject) {


                              NSString *token = [responseObject valueForKeyPath:@"auth_token"];
                              if (token) {
                                  [[A0SimpleKeychain keychain] setString:token forKey:TOKEN_KEY];
                                  //[httpClient setToken:token];
                                  [self showTabHomePage];
                              }


                          }
                          failure:^(AFHTTPRequestOperation *task, NSError *error) {

                              NSError *e = [NSError errorWithDomain:@"dfg" code:0 userInfo:@{
                                      NSLocalizedDescriptionKey : @"My custom text lala"
                              }];

                              UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Error"
                                            message:e.localizedDescription
                                           delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil];

                              [alertView show];
                          }];

}

- (void)showTabHomePage {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UINavigationController *viewController = (UINavigationController *)[storyboard instantiateViewControllerWithIdentifier:@"NavigationView"];
//    [self presentViewController:viewController
//                       animated:YES
//                     completion:nil];

        TabHomeViewController *viewController = (TabHomeViewController *)[storyboard instantiateViewControllerWithIdentifier:@"TabHomePage"];
        [self presentViewController:viewController
                           animated:YES
                         completion:nil];

}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)saveLogin:(NSString *)login andPassword:(NSString *)password
{
    [[A0SimpleKeychain keychain] setString:@"123" forKey:@"com.eatnow.lunchmaster.token"];

    NSLog(@"Save pw: %@", [self.txtPassword text]);

}

- (void)setDisplayingSettingsForButtonsAndTextFields {
    CALayer *txtLoginBottomBorder = [CALayer layer];
    txtLoginBottomBorder.frame = CGRectMake(0.0f, self.login.frame.size.height - 1, self.login.frame.size.width, 1.0f);
    txtLoginBottomBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    CALayer *txtLoginTopBorder = [CALayer layer];
    txtLoginTopBorder.frame = CGRectMake(0.0f, 0.0f, self.login.frame.size.width, 1.0f);
    txtLoginTopBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    CALayer *txtLoginLeftBorder = [CALayer layer];
    txtLoginLeftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, self.login.frame.size.height);
    txtLoginLeftBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    CALayer *txtLoginRightBorder = [CALayer layer];
    txtLoginRightBorder.frame = CGRectMake(self.login.frame.size.width - 1, 0.0f, self.login.frame.size.width - 1, self.login.frame.size.height - 1);
    txtLoginRightBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    
    [self.login.layer addSublayer:txtLoginTopBorder];
    [self.login.layer addSublayer:txtLoginBottomBorder];
    [self.login.layer addSublayer:txtLoginLeftBorder];
    [self.login.layer addSublayer:txtLoginRightBorder];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imageView setImage:[UIImage imageNamed:@"user_icon.png"]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.alpha = 0.3f;
    
    self.login.leftViewMode = UITextFieldViewModeAlways;
    self.login.leftView = imageView;
    
    
    CALayer *txtPasswordBottomBorder = [CALayer layer];
    txtPasswordBottomBorder.frame = CGRectMake(0.0f, self.login.frame.size.height - 1, self.login.frame.size.width, 1.0f);
    txtPasswordBottomBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
   
    CALayer *txtPasswordLeftBorder = [CALayer layer];
    txtPasswordLeftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, self.login.frame.size.height);
    txtPasswordLeftBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    CALayer *txtPasswordRightBorder = [CALayer layer];
    txtPasswordRightBorder.frame = CGRectMake(self.login.frame.size.width - 1, 0.0f, self.login.frame.size.width - 1, self.login.frame.size.height - 1);
    txtPasswordRightBorder.backgroundColor = [UIColor colorWithWhite: 0.70 alpha:1].CGColor;
    
    [self.password.layer addSublayer:txtPasswordBottomBorder];
    [self.password.layer addSublayer:txtPasswordLeftBorder];
    [self.password.layer addSublayer:txtPasswordRightBorder];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imageView setImage:[UIImage imageNamed:@"password_icon.png"]];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.alpha = 0.3f;
    
    self.password.leftViewMode = UITextFieldViewModeAlways;
    self.password.leftView = imageView;
    
    self.btnSignInWithGoogle.layer.cornerRadius = 5;
    self.btnSignInWithGoogle.clipsToBounds = YES;
    
    self.btnSignInWithFacebook.layer.cornerRadius = 5;
    self.btnSignInWithFacebook.clipsToBounds = YES;
    
    self.btnLogin.layer.cornerRadius = 5;
    self.btnLogin.clipsToBounds = YES;
    
    
}

//- (void)getLoginAndPassword
//{
//    NSString *password = [[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"];
//    NSLog(@"Get pw: %@", password);
//}
//
//- (void)deleteItem
//{
//    [[A0SimpleKeychain keychain] deleteEntryForKey:@"com.eatnow.lunchmaster.token"];
//    NSLog(@"Delete pw");
//}

@end
