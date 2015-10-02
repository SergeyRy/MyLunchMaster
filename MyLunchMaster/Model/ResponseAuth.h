//
// Created by Employee on 24.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ResponseAuth : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *login;

@end