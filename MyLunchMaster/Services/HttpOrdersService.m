//
// Created by Employee on 24.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <RestKit/Network/RKResponseDescriptor.h>
#import "HttpOrdersService.h"
#import "AFHTTPClient.h"
#import "RKObjectManager.h"
#import "Eater.h"
#import "RKObjectRequestOperation.h"
#import "RKMappingResult.h"
#import "RKLog.h"
#import "RKMIMETypes.h"
#import "A0SimpleKeychain.h"
#import "Order.h"


@implementation HttpOrdersService {


}

- (void)configureRestKit {
    NSURL *baseUrl = [NSURL URLWithString:getOrdersForCurrentWeekURLString];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseUrl];

    [client setDefaultHeader:@"X-Auth-Token" value:[[A0SimpleKeychain keychain] stringForKey:@"com.eatnow.lunchmaster.token"]];
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];

    RKObjectMapping *eaterMapping = [RKObjectMapping mappingForClass:[Eater class]];
    [eaterMapping addAttributeMappingsFromDictionary:@{@"first_name": @"name", @"id": @"id"}];

    RKObjectMapping *ordersMapping = [RKObjectMapping mappingForClass:[Order class]];
    [eaterMapping addAttributeMappingsFromDictionary:@{@"allergens": @"allergens", @"order_id": @"id"}];


    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:eaterMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:@""
                                                                                           keyPath:@""
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptor];


}

- (void)getOrdersForCurrentWeekSuccess:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                               failure:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure {

    [[RKObjectManager sharedManager] getObjectsAtPath:@""
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

                                                  success(operation, mappingResult);
                                                  //NSArray *result = mappingResult.array;

                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  failure(operation, error);
                                              }];
}



@end