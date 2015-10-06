//
//  KeychainHelper.m
//  MyLunchMaster
//
//  Created by Employee on 15.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "KeychainHelper.h"#import "A0SimpleKeychain.h"

@implementation KeychainHelper

+ (KeychainHelper *)getInstance {
    static KeychainHelper *_keychainHelper = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _keychainHelper = [[self alloc] init];
    });
    return _keychainHelper;
}

- (NSString *)getToken {
    return [[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"];
}


@end
