//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "OrderHistoryService.h"
#import "OrderHistory.h"
#import "Reachability.h"
#import "OrderHistoryDAO.h"
#import "OrderHistoryNAO.h"


@interface OrderHistoryService ()

@property(nonatomic, strong)OrderHistoryDAO *orderHistoryDAO;
@property(nonatomic, strong)OrderHistoryNAO *orderHistoryNAO;

@end

@implementation OrderHistoryService {}


- (void)initData {
    self.orderHistoryDAO = [[OrderHistoryDAO alloc] init];
    self.orderHistoryNAO = [[OrderHistoryNAO alloc] initWithToken];
    self.orderHistoryItems = self.getOrderHistoryItems;
}

- (NSMutableArray *)getOrderHistoryItems {
    id<OrderHistory> orderHistoryDataObject = self.getOrderHistoryDataObject;
    self.orderHistoryItems = orderHistoryDataObject.getOrderHistoryItems;

    if (self.orderHistoryItems.count > 0 && self.internetConnectionIsAvailable) {
        [self.orderHistoryDAO saveOrderHitroryItems:self.orderHistoryItems];
    }

    return self.orderHistoryItems;
}

- (id<OrderHistory>)getOrderHistoryDataObject {
    if (self.internetConnectionIsAvailable) {
        return self.orderHistoryNAO;
    } else {
        return self.orderHistoryDAO;
    }
}

- (BOOL)internetConnectionIsAvailable {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        return NO;
    } else {
        NSLog(@"There IS internet connection");
        return YES;
    }
}

@end