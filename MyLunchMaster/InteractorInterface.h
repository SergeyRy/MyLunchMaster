//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol InteractorInterface <NSObject>

- (void)getMealList;
- (void)getDayOfWeek;
- (void)getCurrentDate;
- (void)setSelectedRow:(NSInteger)index;

@end