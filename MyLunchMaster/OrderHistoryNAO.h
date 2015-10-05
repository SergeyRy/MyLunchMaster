//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "OrderHistory.h"

@interface OrderHistoryNAO : AFHTTPRequestOperationManager <OrderHistory>

- (instancetype)init;
- (NSArray *)getOrderHistoryItemsForEater:(int)eaterId;

@end