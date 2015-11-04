//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "ListMealPresenter.h"
#import "ViewInterface.h"
#import "InteractorInterface.h"


@implementation ListMealPresenter {

}

- (void)getMealList {
    [self.interactor getMealList];
}

- (void)updateDayOfWeek:(NSString *)dayOfWeek {

}

- (void)updateCurrentDay:(NSString *)currentDate {

}

- (void)updateTable {

}

- (void)updateMealList:(NSMutableArray *)mealList {
    [self.viewController updateMealList: mealList];
}

- (void)setSelectedRow:(NSInteger)index {
    [self.interactor setSelectedRow:index];
}


@end