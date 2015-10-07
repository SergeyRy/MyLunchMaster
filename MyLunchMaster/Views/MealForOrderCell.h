//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ListMealCellDelegate;

@interface MealForOrderCell : UITableViewCell

@property (weak, nonatomic) id<ListMealCellDelegate>delegate;
@property (assign, nonatomic) NSInteger cellIndex;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descr;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UIImageView *mealImage;
@property (weak, nonatomic) IBOutlet UIImageView *imgOk;
@property (weak, nonatomic) IBOutlet UIButton *addMealToCartButton;

- (IBAction)addMealToCart:(id)sender;

@end