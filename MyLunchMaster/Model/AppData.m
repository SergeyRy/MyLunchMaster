//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "AppData.h"
#import "Eater.h"
#import "Order.h"


@implementation AppData

+ (id) getInstance {
    static AppData *_appData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appData = [[self alloc] init];
    });
    return _appData;
}

- (Order *)getOrderForEaterForCurrentEaterBySectionIndex:(NSInteger)numberOfSection {
    NSArray *arrayForEater = self.weekOrders[self.currentEater];

    NSPredicate *theDayEquelSection = [NSPredicate predicateWithBlock:
            ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return (numberOfSection + 1) == ([[evaluatedObject dayOfWeekNumber] integerValue]);
            }];

    return [arrayForEater filteredArrayUsingPredicate:theDayEquelSection][0];
}

- (NSInteger)getCountOrderForCurrentEaterBySectionIndex:(NSInteger)numberOfSection {
    NSArray *arrayForEater = self.weekOrders[self.currentEater];

    NSPredicate *theDayEquelSection = [NSPredicate predicateWithBlock:
            ^BOOL(id evaluatedObject, NSDictionary *bindings) {
                return (numberOfSection + 1) == ([[evaluatedObject dayOfWeekNumber] integerValue]);
            }];
    NSArray *filteredOrders = [arrayForEater filteredArrayUsingPredicate:theDayEquelSection];
    return (filteredOrders) ? filteredOrders.count : 0;
}

@end