//
// Created by Employee on 18.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "MealDetailController.h"
#import "Order.h"
#import "Meal.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"


@implementation MealDetailController {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.lblTitle.text = [self.order.meal title];
    self.lblAlergens.text = [self.order.meal allergens];
    self.lblDescription.text = [self.order.meal descr];

    NSString *imageUrl= [NSString stringWithFormat:@"%@%@", BASE_URL, self.order.meal.imagePath];

    NSURL *url = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    UIImage *placeholderImage = [UIImage imageNamed:@"none"];


    self.imageMeal.contentMode = UIViewContentModeScaleAspectFill;
    [self.imageMeal setImageWithURLRequest:request
                          placeholderImage:placeholderImage
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       self.imageMeal.image = image;

                                   } failure: ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                NSLog(@"%@", error);
            }];


}

@end