//
// Created by Employee on 24.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <RestKit/Network/RKResponseDescriptor.h>
#import "HttpAuthService.h"
#import "AFHTTPClient.h"
#import "RKObjectManager.h"
#import "Constants.h"
#import "ResponseAuth.h"
#import "RKNSJSONSerialization.h"
#import "RKMIMETypeSerialization.h"
#import "AFHTTPRequestOperation.h"
#import "RKLog.h"
#import "RKObjectRequestOperation.h"
#import "RKMappingResult.h"


@implementation HttpAuthService {

}

- (void)configureRestKit {
    NSURL *baseURL = [NSURL URLWithString:@"https://eatnow.thelunchmaster.com/api/v1/users/sign_in"];
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:baseURL];

    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];

    RKObjectMapping *responseAuthMapping = [RKObjectMapping mappingForClass:[ResponseAuth class]];
    [responseAuthMapping addAttributeMappingsFromDictionary:@{@"success": @"success",
                                                    @"auth_token": @"token",
                                                         @"login": @"login"}];

    [objectManager setRequestSerializationMIMEType: RKMIMETypeJSON];

    [objectManager addResponseDescriptor:[RKResponseDescriptor responseDescriptorWithMapping:responseAuthMapping
                                                                                      method:RKRequestMethodAny
                                                                                 pathPattern:@""
                                                                                     keyPath:nil
                                                                                 statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful) ]];
}

- (void)loginInUsingLogin:(NSString *)login
              andPassword:(NSString *)password
                  success:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
                  failure:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure {

    NSDictionary *parameters = @{@"login": login,
                              @"password": password};

    [[RKObjectManager sharedManager] postObject:@""
                                           path:@""
                                     parameters:parameters
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            success(operation, mappingResult);
                                            //ResponseAuth *response = (ResponseAuth *)[mappingResult.array firstObject];

                                        }
                                        failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            failure(operation, error);
                                        }];
}

@end