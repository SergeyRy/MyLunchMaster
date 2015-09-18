//
// Created by Employee on 18.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Order;


@interface MealDetailController : UIViewController

    @property (strong, nonatomic) IBOutlet UILabel *lblTitle;
    @property (strong, nonatomic) IBOutlet UILabel *lblAlergens;
    @property (strong, nonatomic) IBOutlet UILabel *lblDescription;
    @property (strong, nonatomic) IBOutlet UIImageView *imageMeal;

    @property (nonatomic, strong) Order *order;
@end