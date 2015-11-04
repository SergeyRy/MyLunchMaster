//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PresenterInterface <NSObject>

- (void)updateDayOfWeek:(NSString *)dayOfWeek;
- (void)updateCurrentDay:(NSString *)currentDate;
- (void)updateTable;
- (void)updateMealList:(NSMutableArray *)mealList;
- (void)setSelectedRow:(NSInteger)index;

@end