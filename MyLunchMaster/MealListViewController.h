//
//  MealListViewController.h
//  MyLunchMaster
//
//  Created by Employee on 06.10.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewInterface.h"
#import "ListMealCellDelegate.h"

@class ListMealPresenter;

@interface MealListViewController : UITableViewController<ViewInterface, ListMealCellDelegate>

@property (nonatomic, strong) ListMealPresenter *presenter;

@end
