//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Meal : NSObject

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descr;
@property (nonatomic, strong) NSString *allergens;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *price;
@property (nonatomic) BOOL isSelected;

- (id) initWithId:(NSNumber *)id title:(NSString *) title descr:(NSString *) descr allergens:(NSString *)allergens imagePath:(NSString *) imagePath;

@end