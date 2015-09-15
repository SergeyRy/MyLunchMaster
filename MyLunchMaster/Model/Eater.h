//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Eater : NSObject

@property NSNumber *id;
@property (nonatomic, strong) NSString *name;

- (id) initWithId:(NSNumber *)id andName:(NSString *) name;

@end