//
//  MealListViewController.h
//  MyLunchMaster
//
//  Created by Employee on 06.10.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListMealPresenter;

@interface MealListViewController : UITableViewController

@property (nonatomic, strong)   ListMealPresenter *presenter;

@end
