//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ListMealPresenter : NSObject

@property (nonatomic, weak)     id<CNTCountView>            viewController;
@property (nonatomic, strong)   id<CNTCountInteractorInput> interactor;

@end