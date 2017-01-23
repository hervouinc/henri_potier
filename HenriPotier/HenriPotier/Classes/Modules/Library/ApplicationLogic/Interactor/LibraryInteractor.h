//
//  LibraryInteractor.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LibraryInteractorIO.h"
#import "AppReachability.h"

@class LibraryDataManager;

@interface LibraryInteractor : NSObject <LibraryInteractorInput, AppReachabilityInterface>

@property (nonatomic, weak)     id<LibraryInteractorOutput> output;

- (instancetype)initWithDataManager:(LibraryDataManager *)dataManager;

@end
