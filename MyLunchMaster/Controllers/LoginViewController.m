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


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLoginClicked:(id)sender {
    HttpApiHelper *httpClient = [HttpApiHelper httpClient];
    [httpClient loginWithUserName:[self.txtLogin text]
                         password:[self.txtPassword text]
                          success:^(AFHTTPRequestOperation *task, id responseObject) {
                              NSString *token = [responseObject valueForKeyPath:@"auth_token"];
                              if (token) {
                                  [[A0SimpleKeychain keychain] setString:[self.txtPassword text] forKey:TOKEN_KEY];
                                  [httpClient setToken:token];
                              }
                           }
                          failure:^(AFHTTPRequestOperation *task, NSError *error) {

                          }];

}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

//- (void)saveLogin:(NSString *)login andPassword:(NSString *)password
//{
//    NSString *token = [self.txtPassword text];
//    [[A0SimpleKeychain keychain] setString:@"123" forKey:@"com.eatnow.lunchmaster.token"];
//
//
//    NSLog(@"Save pw: %@", [self.txtPassword text]);
//
//}
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
