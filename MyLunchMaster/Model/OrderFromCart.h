//
// Created by Employee on 30.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Order.h"


@interface OrderFromCart : Order

@property (nonatomic, strong) NSString *mealDescr;
@property (nonatomic, strong) NSString *mealSize;

- (id) initWithId:(NSNumber *)id date:(NSString *) date mealDescr:(NSString *) mealDescr mealSize:(NSString *)mealSize price:(NSString *) price;

@end