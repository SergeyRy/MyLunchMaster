//
// Created by Employee on 21.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface MealCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descr;
@property (weak, nonatomic) IBOutlet UIImageView *mealImage;

-(void)setFrame:(CGRect)frame;

@end