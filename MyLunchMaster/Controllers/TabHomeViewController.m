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

    UIImageView *navigationImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 130, 15)];
    navigationImage.image=[UIImage imageNamed:@"Logo"];
    UIImageView *workaroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 130, 15)];
    [workaroundImageView addSubview:navigationImage];
    self.navigationItem.titleView=workaroundImageView;

//    UIBarButtonItem *changeEaterButton = [[UIBarButtonItem alloc] init];
//    changeEaterButton.title = @"123";
//    NSArray *actionButtonItems = @[changeEaterButton];
//    self.navigationItem.rightBarButtonItems = actionButtonItems;

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
