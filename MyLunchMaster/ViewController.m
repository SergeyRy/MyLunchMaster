//
//  ViewController.m
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "ViewController.h"
#import "HttpApiHelper.h"
#import <AFNetworking/AFNetworking.h>

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
                              NSLog(@"Success -- %@", responseObject);                              
                          }
                          failure:^(AFHTTPRequestOperation *task, NSError *error) {
                              NSLog(@"Failure -- %@", error);
                          }];

}

- (IBAction)backgroundTap:(id)sender {
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)goToHomePage
{

}

@end
