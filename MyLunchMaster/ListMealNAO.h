//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperationManager.h"

@class Meal;


@interface ListMealNAO : AFHTTPRequestOperationManager

- (NSMutableArray *)getMealList;
- (BOOL)addMealToCart:(Meal *)meal;

@end