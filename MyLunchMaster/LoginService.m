//
//  LoginService.m
//  MyLunchMaster
//
//  Created by Employee on 11.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import "LoginService.h"
#import "LoginDataProvider.h"
#import "SimpleKeychain.h"
#import "Constants.h"

@implementation LoginService


-(BOOL)loginWithLogin: (NSString *)login AndPassword: (NSString *)password {
    LoginDataProvider *dataProvider = [[LoginDataProvider alloc] init];
    NSString *token = [dataProvider loginWithLogin:login AndPassword:password];
    
    if (token) {
        [[A0SimpleKeychain keychain] setString:token forKey:TOKEN_KEY];
        return YES;
    }
    
    return NO;
}

@end
