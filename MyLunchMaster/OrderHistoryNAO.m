//
// Created by Employee on 05.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "OrderHistoryNAO.h"
#import "KeychainHelper.h"
#import "HttpApiHelper.h"
#import "JsonParserHelper.h"
#import <AFHTTPRequestOperationManager+Synchronous.h>

NSString * const _baseURLString = @"https://eatnow.thelunchmaster.com";
NSString * const getOrderHistoryItemsURL = @"api/v1/orders_history";

@interface OrderHistoryNAO()
    @property (nonatomic, strong)  NSString *token;
    @property (nonatomic, strong)  NSString *baseURLString;
@end

@implementation OrderHistoryNAO {}

- (instancetype)initWithToken {

    self = [super initWithBaseURL:[NSURL URLWithString:baseURLString]];
    if (!self) {
        return nil;
    }

    self.token = KeychainHelper.getInstance.getToken;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

- (NSMutableArray *)getOrderHistoryItems {
    [self.requestSerializer setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    NSError *error = nil;
    NSData *result = [self syncGET:getOrderHistoryItemsURL parameters:nil operation:NULL error:&error];

    return [JsonParserHelper.getInstance parseOrderHistoryItems:(NSMutableArray *)[result valueForKeyPath:@"orders"]];
}

@end