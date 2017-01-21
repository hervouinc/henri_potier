//
//  AppDependencies.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "AppDependencies.h"

@interface AppDependencies ()
@end

@implementation AppDependencies

- (instancetype)init
{
    if(self = [super init])
    {
        [self configureDependencies];
    }
    return self;
}

- (void)installRootViewControllerIntoWindow:(id)window
{
}

- (void)configureDependencies
{
}

@end
