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
    [self.navigationController setNavigationBarHidden:YES];

    NSLog(@"login view did load");
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginClicked:(id)sender {
    HttpApiHelper *httpClient = [HttpApiHelper httpClient];
    [httpClient loginWithUserName:self.txtLogin.text
                         password:self.txtPassword.text
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
//
//- (void)getLoginAndPassword
//{
//    NSString *password = [[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"];
//    NSLog(@"Get pw: %@", password);
//
//
//}
//
//- (void)deleteItem
//{
//    [[A0SimpleKeychain keychain] deleteEntryForKey:@"com.eatnow.lunchmaster.token"];
//    NSLog(@"Delete pw");
//}

@end
