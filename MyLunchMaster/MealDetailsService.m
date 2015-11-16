//
//  MealDetailsService.m
//  MyLunchMaster
//
//  Created by Employee on 16.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import "MealDetailsService.h"
#import "HttpApiHelper.h"


@implementation MealDetailsService

-(void)addMealToCart:(NSString *)mealId
             forUser:(NSString *)eaterId
             forDate:(NSString *)date
             success:(void(^)(AFHTTPRequestOperation *task, id responseObject))success
             failure:(void(^)(AFHTTPRequestOperation *task, NSError *error))failure {

    [[HttpApiHelper httpClient] addMealToCardWithMealId:mealId
                                             forEaterId:eaterId
                                                forDate:date
                                                success:success
                                                failure:failure];
}

@end
