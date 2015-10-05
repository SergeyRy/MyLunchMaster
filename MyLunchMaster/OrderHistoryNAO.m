//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "OrderHistoryNAO.h"

NSString * const _baseURLString = @"https://eatnow.thelunchmaster.com";
NSString * const getOrderHistoryForEater = @"api/v1/orders_history";

@interface OrderHistoryNAO()
    @property (nonatomic, strong)  NSString *token;
@end

@implementation OrderHistoryNAO {}

- (instancetype)initWithToken:(NSString *)token {

    self = [super initWithBaseURL:_baseURLString];
    if (!self) {
        return nil;
    }

    self.token = token;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (NSMutableArray *)getOrderHistoryItemsForEater:(int)eaterId {
    NSMutableArray *result = [[NSMutableArray alloc] init];

    [self.requestSerializer setValue:_token forHTTPHeaderField:@"X-Auth-Token"];
    [self GET:getOrderHistoryForEater parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"getOrderHistoryItemsForEater Error");
    }];

    return result;
}

@end