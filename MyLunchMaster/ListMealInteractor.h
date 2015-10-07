//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InteractorInterface.h"

@protocol PresenterInterface;


@interface ListMealInteractor : NSObject<InteractorInterface>

@property (nonatomic, weak) id<PresenterInterface> presenter;

@end