//
//  RootViewController.m
//  MyLunchMaster
//
//  Created by Employee on 15.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "RootViewController.h"
#import "SimpleKeychain.h"
#import "LoginViewController.h"
#import "TabHomeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Root controll viewDidLoad");
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"Root controll viewDidAppear");

    if(![[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"]) {
        NSLog(@"Go to Login screnen ");
        [self showLoginScreen];
    } else {
        NSLog(@"Go to Tab home screnen ");
        [self showTabHomePage];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showLoginScreen
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *viewController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"LoginPage"];
    [self presentViewController:viewController
                       animated:NO
                     completion:nil];
}

-(void)showTabHomePage {
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
