//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PresenterInterface.h"

@protocol ViewInterface;
@protocol InteractorInterface;


@interface ListMealPresenter : NSObject<PresenterInterface>

@property (nonatomic, weak)     id<ViewInterface> viewController;
@property (nonatomic, strong)   id<InteractorInterface> interactor;

- (void)getMealList;

@end