//
// Created by Employee on 17.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "JsonParserHelper.h"
#import "Eater.h"
#import "Meal.h"
#import "Order.h"


@implementation JsonParserHelper {

}

- (NSMutableArray *) parceJsonEaters: (NSArray *) eaters {
    NSMutableArray *result = [[NSMutableArray alloc] init];

    for (NSDictionary *item in eaters) {
        Eater *eater = [[Eater alloc] initWithId:item[@"id"] andName:item[@"first_name"]];
        [result addObject:eater];
    }

    return result;
}

- (NSMutableDictionary *) parseJsonOrders: (NSMutableDictionary *) orders : (NSArray *) eaters {
    NSMutableDictionary *weekOrders = [[NSMutableDictionary alloc] init];

    if ([eaters count] > 0) {
        for (Eater *eater in eaters) {
            NSMutableArray *eaterOrders = [[NSMutableArray alloc] init];

            for (NSDictionary *order in orders[[[eater id] stringValue]]) {

                NSString *orderId = order[@"order_id"];
                NSNumber *orderPrice = (NSNumber *)order[@"order_price"];
                NSString *allergens = order[@"allergens"];
                NSString *orderDate = order[@"meal_date"];

                NSString *mealId = order[@"meal_items"][@"id"];
                NSString *mealTitle = order[@"meal_items"][@"title"];
                NSString *mealDescription = order[@"meal_items"][@"description"];
                NSString *mealPictureUrl = order[@"meal_picture_url"];

                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd"];
                NSDate *dte = [dateFormat dateFromString:orderDate];

                [dateFormat setDateFormat:@"EEEE"]; // day, like "Saturday"
                NSString *dayOfWeekString = [dateFormat stringFromDate:dte];

                [dateFormat setDateFormat:@"c"]; // day number, like 7 for saturday
                NSNumber *dayOfWeekNumber = [dateFormat stringFromDate:dte];

                Meal *meal = [[Meal alloc] initWithId:mealId title:mealTitle descr:mealDescription allergens:allergens imagePath:mealPictureUrl];
                Order *order = [[Order alloc] initWithId:orderId date:orderDate dayOfWeekString:dayOfWeekString dayOfWeekNumber:dayOfWeekNumber price:orderPrice meal:meal];

                [eaterOrders addObject:order];
            }

            [weekOrders setObject:eaterOrders forKey:eater];
        }
    }

    return weekOrders;
}

@end