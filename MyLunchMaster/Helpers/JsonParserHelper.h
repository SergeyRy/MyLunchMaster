//
// Created by Employee on 17.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JsonParserHelper : NSObject

+ (JsonParserHelper *)getInstance;

- (NSMutableArray *) parseEaters: (NSArray *) eaters;
- (NSMutableDictionary *) parseOrders: (NSMutableDictionary *) orders : (NSArray *) eaters;

@end