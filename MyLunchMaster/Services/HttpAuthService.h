//
// Created by Employee on 24.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;
@class RKMappingResult;
@class RKObjectRequestOperation;


@interface HttpAuthService : NSObject

- (void)configureRestKit;
- (void)loginInUsingLogin:(NSString *)login
              andPassword:(NSString *)password
                  success:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end