//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "ListMealNAO.h"
#import "Meal.h"
#import "HttpApiHelper.h"
#import "KeychainHelper.h"
#import "JsonParserHelper.h"
#import "AFHTTPRequestOperationManager+Synchronous.h"

NSString * const getMealListURL = @"api/v1/meals_menu/%@/%@";

@interface ListMealNAO ()

@property (nonatomic, strong)  NSString *token;

@end

@implementation ListMealNAO {}

- (instancetype)init {

    self = [super initWithBaseURL:[NSURL URLWithString:baseURLString]];
    if (!self) {
        return nil;
    }

    self.token = KeychainHelper.getInstance.getToken;
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}


- (NSMutableArray *)getMealListBy:(NSString *)eaterId andDate:(NSString *)day {
    [self.requestSerializer setValue:self.token forHTTPHeaderField:@"X-Auth-Token"];
    NSError *error = nil;
    NSData *result = [self syncGET:[NSString stringWithFormat:getMealListURL, eaterId, day] parameters:nil operation:NULL error:&error];

    return [JsonParserHelper.getInstance parseMealListItems:(NSMutableArray *)[result valueForKeyPath:@"meals_list"]];
}

- (BOOL)addMealToCart:(Meal *)meal {
    return NO;
}


@end