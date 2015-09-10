//
//  ViewHomeController.m
//  MyLunchMaster
//
//  Created by Employee on 10.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "ViewHomeController.h"

@implementation ViewHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    //    [self performSegueWithIdentifier:@"Login_succes" sender:self];
}

@end
