//
//  ThhpApiHelper.m
//  MyLunchMaster
//
//  Created by Employee on 09.09.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import "HttpApiHelper.h"

NSString * const baseURLString = @"https://eatnow.thelunchmaster.com";
NSString * const authorizationURLString = @"api/v1/users/sign_in";
NSString * const getOrdersForCurrentWeekURLString = @"api/v1/weekly_order";



@implementation HttpApiHelper

+ (HttpApiHelper *)httpClient {
    static HttpApiHelper *_httpClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _httpClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseURLString]];
    });
    return _httpClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (void)loginWithUserName:(NSString *)login
                 password:(NSString *)password
                  success:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
                  failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure
{
    NSDictionary *parameters = @{@"login": login,
                              @"password": password};

    [self POST:authorizationURLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void)getOrdersForCurrentWeekSuccess:(void (^)(AFHTTPRequestOperation *task, id responseObject))success
                               failure:(void (^)(AFHTTPRequestOperation *task, NSError *error))failure {

    [self.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
    [self GET:getOrdersForCurrentWeekURLString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

@end
