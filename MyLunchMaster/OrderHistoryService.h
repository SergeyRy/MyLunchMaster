//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderHistoryService : NSObject

@property (nonatomic, strong) NSMutableArray *orderHistoryItems;

- (void) initData;

@end