//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ViewInterface <NSObject>
- (void)setDayOfWeek:(NSString*)dayOfWeek;
- (void)setCurrentDate:(NSString*)currentDate;
- (void)updateMealList:(NSMutableArray *)mealList;
@end