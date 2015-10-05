//
//  OrderDetailCellTableViewCell.h
//  MyLunchMaster
//
//  Created by Employee on 05.10.15.
//  Copyright (c) 2015 Employee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *eaterName;
@property (weak, nonatomic) IBOutlet UILabel *mealDescr;
@property (weak, nonatomic) IBOutlet UILabel *dateOrder;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UIImageView *imgDelete;



@end
