//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "Eater.h"


@implementation Eater {}

- (id) initWithId:(NSNumber *)id andName:(NSString *) name {
    self = [super init];
    if (self) {
        self.id = id;
        self.name = name;
    }
    return self;
}

@end