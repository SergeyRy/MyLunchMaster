//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Eater.h"
#import "Order.h"

@interface AppData : NSObject

@property (nonatomic, strong) NSMutableArray *eaters;
@property (nonatomic, strong) Eater *currentEater;
@property (nonatomic, strong) NSMutableDictionary *weekOrders;

+ (AppData *)getInstance;
- (Order *)getOrderForEaterForCurrentEaterBySectionIndex:(NSInteger *)numberOfSection;
- (NSNumber *)getCountOrderForCurrentEaterBySectionIndex:(NSInteger *)numberOfSection;

@end

