//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderHistory.h"
#import <CoreData/CoreData.h>


@interface OrderHistoryDAO : NSObject <OrderHistory>

- (NSArray *)getOrderHistoryItems;
- (void)saveOrderHitroryItems:(NSMutableArray *)items;


@end