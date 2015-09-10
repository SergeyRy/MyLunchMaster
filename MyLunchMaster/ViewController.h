//
//  ViewController.h
//  MyLunchMaster
//
//  Created by Employee on 07.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtLogin;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

- (IBAction)btnLoginClicked:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@end

