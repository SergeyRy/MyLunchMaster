//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "ListMealInteractor.h"
#import "PresenterInterface.h"
#import "ListMealNAO.h"

@interface ListMealInteractor ()

@property (nonatomic, strong)ListMealNAO *listMealNAO;
@property (nonatomic, strong)NSMutableArray *mealList;

@end

@implementation ListMealInteractor {}

- (instancetype)init {

    self = [super init];
    if (!self) {
        return nil;
    }

    self.listMealNAO = [[ListMealNAO alloc] init];
    return self;
}

- (void)getMealList {
    self.mealList = self.listMealNAO.getMealList;
    [self.presenter updateMealList:self.mealList];
}

- (void)getDayOfWeek {

}

- (void)getCurrentDate {

}


@end