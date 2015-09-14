//
//  TabHomeViewController.m
//  MyLunchMaster
//
//  Created by Employee on 10.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "TabHomeViewController.h"


@implementation TabHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];

    NSLog(@"tab bar view did load");
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

@end
