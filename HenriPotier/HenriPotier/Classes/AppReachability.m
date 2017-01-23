//
//  AppReachability.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "AppReachability.h"
#import "AFNetworking.h"

@interface AppReachability ()
@property (nonatomic, assign) BOOL reachable;
@end

@implementation AppReachability

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    self.reachable = YES;
    [self observeReachability];

    return self;
}

- (void)observeReachability
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {

        if(self.reachable != [[AFNetworkReachabilityManager sharedManager] isReachable])
        {
            self.reachable = [[AFNetworkReachabilityManager sharedManager] isReachable];

            [self.eventHandler reachabilityDidChange:self.reachable];
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
