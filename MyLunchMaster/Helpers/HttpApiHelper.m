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
NSString * const getShoppCart = @"api/v1/shopping_cart_orders";
NSString * const addMealToCartUrl = @"api/v1/add_to_cart/";


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

- (void)getShoppingCartSuccess:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
                       failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure {
    
    [self.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
    [self GET:getShoppCart parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
    }];
}

- (void)addMealToCardWithMealId:(NSString *)mealId
                     forEaterId:(NSString *)eaterId
                        forDate:(NSString *)date
                        success:(nonnull void(^)(AFHTTPRequestOperation *task, id responseObject))success
                        failure:(nonnull void(^)(AFHTTPRequestOperation *task, NSError *error))failure {
    
    NSDictionary *parameters = @{@"daily_school_menu_id": @"1636980",
                                 @"eater_id": eaterId,
                                 @"meal_date": date,
                                 @"meal_size": @"regular",
                                 @"menu_item_id": mealId,
                                 @"school_menu_id": @"223"                                 };
    
    [self.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
    NSString *n = [NSString stringWithFormat:@"%@%@", addMealToCartUrl, parameters];
    [self GET: n parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", error);
        failure(operation, error);
    }];
}
@end
