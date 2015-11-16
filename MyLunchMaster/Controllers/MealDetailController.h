//
// Created by Employee on 18.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Meal.h"

@class Order;

typedef NS_ENUM(NSInteger, TypeMealDetailPage) {
    TypeMealDetailPageForView,
    TypeMealDetailPageForOrder
};

@interface MealDetailController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtAlergents;
@property (weak, nonatomic) IBOutlet UILabel *txtDescription;
@property (strong, nonatomic) IBOutlet UIImageView *imageMeal;

@property (nonatomic) TypeMealDetailPage typePage;
@property (nonatomic, strong) Meal *meal;
@property (nonatomic, strong) NSString *selectedDate;

@end