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

- (id)copyWithZone:(NSZone *)zone {
    Eater *result = [[[self class] allocWithZone:zone] init];

    if (result)
    {
        result.id = [_id copyWithZone:zone];
        result.name = [_name copyWithZone:zone];
    }

    return result;
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return YES;
    }

    if (![object isKindOfClass:[self class]]) {
        return NO;
    }

    if ([object id] == [self id]) {
        return YES;
    }

    return NO;
}

- (NSUInteger)hash {
    return [self id];
}

@end