//
// Created by Employee on 07.10.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "MealForOrderCell.h"
#import "ListMealCellDelegate.h"


@implementation MealForOrderCell {

}
- (IBAction)addMealToCart:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didClickOnCellAtIndex:withData:)]) {
        [self.delegate didClickOnCellAtIndex:_cellIndex withData:@"any other cell data/property"];
    }
}
@end