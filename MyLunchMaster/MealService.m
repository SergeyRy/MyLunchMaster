//
//  MealService.m
//  MyLunchMaster
//
//  Created by Employee on 13.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import "MealService.h"
#import "ListMealNAO.h"

@implementation MealService

- (NSMutableArray *)getMealListBy:(NSString *) eaterId andDate: (NSString *) day {
    ListMealNAO *dataProvider = [[ListMealNAO alloc] init];
    return [dataProvider getMealListBy:eaterId andDate:day];
}

@end
