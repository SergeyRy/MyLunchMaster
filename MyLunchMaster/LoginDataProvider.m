//
//  LoginDataProvider.m
//  MyLunchMaster
//
//  Created by Employee on 11.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import "LoginDataProvider.h"

@implementation LoginDataProvider

-(NSString *)loginWithLogin:(NSString *)login AndPassword:(NSString *)password {
    
    NSData *returnData = [[NSData alloc]init];
    
    //Build the Request
    NSURL *url = [NSURL URLWithString:@"https://eatnow.thelunchmaster.com/api/v1/users/sign_in"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    //[request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postString length]] forHTTPHeaderField:@"Content-length"];
    
    NSString *postString = [NSString stringWithFormat:@"login=%@&password=%@", login, password];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //Send the Request
    returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    
    //Get the Result of Request
    //NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:returnData options:nil error:&error];
    
    NSString *token = [result objectForKey:@"auth_token"];
    if (!error && result && token) {
        return token;
        
    }
    
    return nil;
    
}

@end
