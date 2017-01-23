//
//  AppReachability.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppReachabilityInterface <NSObject>
- (void)reachabilityDidChange:(BOOL)reachable;
@end

@interface AppReachability : NSObject

@property (nonatomic, strong) id<AppReachabilityInterface> eventHandler;

@end
