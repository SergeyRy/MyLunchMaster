//
// Created by Employee on 21.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "MealCell.h"


@implementation MealCell {

}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 5;
    frame.size.width -= 10;
    [super setFrame:frame];
}

@end