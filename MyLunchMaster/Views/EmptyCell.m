//
//  EmptyCellTableViewCell.m
//  MyLunchMaster
//
//  Created by Employee on 12.11.15.
//  Copyright © 2015 Employee. All rights reserved.
//

#import "EmptyCell.h"

@implementation EmptyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}

@end
