//
//  KeychainHelper.h
//  MyLunchMaster
//
//  Created by Employee on 15.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>@class A0SimpleKeychain;
#import "SimpleKeychain.h"

@interface KeychainHelper : NSObject

+ (KeychainHelper *)getInstance;

- (NSString *)getToken;

@end
