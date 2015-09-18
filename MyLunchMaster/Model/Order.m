//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "Order.h"
#import "Meal.h"


@implementation Order {}

- (id) initWithId:(NSNumber *)id date:(NSString *) date dayOfWeekString:(NSString *) dayOfWeekString dayOfWeekNumber:(NSNumber *)dayOfWeekNumber price:(NSNumber *) price meal:(Meal *) meal {
    self = [super init];
    if (self) {
        self.id = id;
        self.date = date;
        self.dayOfWeekString = dayOfWeekString;
        self.dayOfWeekNumber = dayOfWeekNumber;
        self.price = price;
        self.meal = meal;
    }
    return self;
}

@end