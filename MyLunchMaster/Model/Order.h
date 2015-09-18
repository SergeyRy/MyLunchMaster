//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Meal;


@interface Order : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *dayOfWeekString;
@property (nonatomic, strong) NSNumber *dayOfWeekNumber;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) Meal *meal;

- (id) initWithId:(NSNumber *)id date:(NSString *) date dayOfWeekString:(NSString *) dayOfWeekString dayOfWeekNumber:(NSNumber *)dayOfWeekNumber price:(NSNumber *) price meal:(Meal *) meal;

@end