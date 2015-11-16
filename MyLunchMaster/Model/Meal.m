//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "Meal.h"


@implementation Meal {}

- (id) initWithId:(NSNumber *)id title:(NSString *) title descr:(NSString *) descr allergens:(NSString *)allergens imagePath:(NSString *) imagePath {
    self = [super init];
    if (self) {
        self.id = id;
        self.title = title;
        self.descr = descr;
        self.allergens = allergens;
        self.imagePath = imagePath;
    }
    return self;
}

- (id) initWithId:(NSNumber *)id title:(NSString *) title descr:(NSString *) descr allergens:(NSString *)allergens imagePath:(NSString *) imagePath price:(NSString *) price {
    self = [super init];
    if (self) {
        self.id = id;
        self.title = title;
        self.descr = descr;
        self.allergens = allergens;
        self.imagePath = imagePath;
        self.price = price;
    }
    return self;
}

@end