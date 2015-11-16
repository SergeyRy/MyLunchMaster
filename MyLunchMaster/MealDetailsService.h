//
//  MealDetailsService.h
//  MyLunchMaster
//
//  Created by Employee on 16.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface MealDetailsService : NSObject

-(void)addMealToCart:(NSString *)mealId
             forUser:(NSString *)userId
             forDate:(NSString *)date
             success:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
             failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure;

@end
