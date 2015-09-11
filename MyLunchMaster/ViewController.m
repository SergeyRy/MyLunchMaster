//
//  ViewController.m
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "ViewController.h"
#import "HttpApiHelper.h"
#import <Security/Security.h>

@interface ViewController ()

@end

@implementation ViewController

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
    NSLog(@"button click");
    HttpApiHelper *httpClient = [HttpApiHelper httpClient];
    
    [httpClient loginWithUserName:[self.txtLogin text]
                         password:[self.txtPassword text]
                          success:^(AFHTTPRequestOperation *task, id responseObject) {
                               [self saveLogin:[self.txtLogin text] andPassword:[self.txtPassword text]];
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

- (void)saveLogin:(NSString *)login andPassword:(NSString *)password
{
    NSMutableDictionary *keychainItem = [NSMutableDictionary dictionary];

    NSString *username = self.txtLogin.text;
    NSString *pw = self.txtPassword.text;

    keychainItem[(__bridge id)kSecClass] = (__bridge id)kSecClassInternetPassword;
    keychainItem[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleWhenUnlocked;
    keychainItem[(__bridge id)kSecAttrAccount] = username;


    if(SecItemCopyMatching((__bridge CFDictionaryRef)keychainItem, NULL) == noErr) {

        NSMutableDictionary *attributesToUpdate = [NSMutableDictionary dictionary];
        attributesToUpdate[(__bridge id)kSecValueData] = [password dataUsingEncoding:NSUTF8StringEncoding];

        OSStatus sts = SecItemUpdate((__bridge CFDictionaryRef)keychainItem, (__bridge CFDictionaryRef)attributesToUpdate);
        NSLog(@"Error Code: %d", (int)sts);
        NSLog(@"Update");

    } else {
        keychainItem[(__bridge id)kSecValueData] = [pw dataUsingEncoding:NSUTF8StringEncoding];
        OSStatus sts = SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
        NSLog(@"Add");
    }

}

@end
