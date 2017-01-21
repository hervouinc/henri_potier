//
//  AppDelegate.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDependencies.h"

@interface AppDelegate ()
@property (nonatomic, strong) AppDependencies *appDependencies;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.appDependencies = [[AppDependencies alloc] init];
    [self.appDependencies installRootViewControllerIntoWindow:self.window];

    return YES;
}

@end
