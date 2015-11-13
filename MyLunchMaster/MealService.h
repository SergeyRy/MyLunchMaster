//
//  MealService.h
//  MyLunchMaster
//
//  Created by Employee on 13.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MealService : NSObject

- (NSMutableArray *)getMealListBy:(NSString *) eaterId andDate: (NSString *) day;

@end
