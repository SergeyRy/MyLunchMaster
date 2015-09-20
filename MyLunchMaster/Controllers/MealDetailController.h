//
// Created by Employee on 18.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Order;


@interface MealDetailController : UIViewController

    @property (weak, nonatomic) IBOutlet UILabel *txtTitle;
    @property (weak, nonatomic) IBOutlet UILabel *txtAlergents;
    @property (weak, nonatomic) IBOutlet UITextView *txtDescription;



    @property (strong, nonatomic) IBOutlet UIImageView *imageMeal;

    @property (nonatomic, strong) Order *order;
@end