//
// Created by Employee on 30.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "OrderFromCart.h"


@implementation OrderFromCart {

}

- (id)initWithId:(NSNumber *)id date:(NSString *)date mealDescr:(NSString *)mealDescr mealSize:(NSString *)mealSize price:(NSString *)price {
    self = [super initWithId:id date:date dayOfWeekString:nil dayOfWeekNumber:nil price:price meal:nil];

    if (self) {
        self.mealDescr = mealDescr;
        self.mealSize = mealSize;
        self.price = price;
    }
    return self;
}


@end