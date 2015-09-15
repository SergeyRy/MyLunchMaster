//
// Created by Employee on 15.09.15.
// Copyright (c) 2015 Employee. All rights reserved.
//

#import "AppData.h"
#import "Eater.h"


@implementation AppData

+ (id) getInstance {
    static AppData *_appData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _appData = [[self alloc] init];
    });
    return _appData;
}

@end