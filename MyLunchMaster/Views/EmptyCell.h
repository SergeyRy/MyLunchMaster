//
//  EmptyCellTableViewCell.h
//  MyLunchMaster
//
//  Created by Employee on 12.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descr;
@property (weak, nonatomic) IBOutlet UIImageView *mealImage;

@end
