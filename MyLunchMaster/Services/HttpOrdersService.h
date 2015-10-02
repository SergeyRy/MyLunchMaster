//
// Created by Employee on 24.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@class RKObjectRequestOperation;
@class RKMappingResult;

@interface HttpOrdersService : NSObject

- (void)configureRestKit;
- (void)getOrdersForCurrentWeekSuccess:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                               failure:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end