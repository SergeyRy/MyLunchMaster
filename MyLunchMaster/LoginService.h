//
//  LoginService.h
//  MyLunchMaster
//
//  Created by Employee on 11.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginService : NSObject

-(void)loginWithGoogle;
-(void)loginWithFacebook;
-(BOOL)loginWithLogin: (NSString *)login AndPassword: (NSString *)password;

@end
