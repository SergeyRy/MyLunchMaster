//
// Created by Employee on 06.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OrderHistoryItem : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSDate *mealDate;
@property (nonatomic, strong) NSDate *orderDate;

@end