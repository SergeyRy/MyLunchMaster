//
//  ThhpApiHelper.h
//  MyLunchMaster
//
//  Created by Employee on 09.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString * const baseURLString;

@interface HttpApiHelper : AFHTTPRequestOperationManager
    @property (nonatomic, strong) NSString *token;

+ (HttpApiHelper *)httpClient;

- (void)loginWithUserName:(NSString *)login
               password:(NSString *)password
                success:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
                failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)getOrdersForCurrentWeekSuccess:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
                               failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure;

- (void)getShoppingCartSuccess:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
                       failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure;

@end
