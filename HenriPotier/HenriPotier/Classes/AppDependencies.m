//
//  AppDependencies.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "AppDependencies.h"

#import "AppReachability.h"
#import "RootWireframe.h"
#import "LocalDataStore.h"
#import "LocalCachedDataStore.h"
#import "RemoteDataStore.h"

#import "LibraryWireframe.h"
#import "LibraryPresenter.h"
#import "LibraryDataManager.h"
#import "LibraryInteractor.h"

#import "CartWireframe.h"
#import "CartPresenter.h"
#import "CartDataManager.h"
#import "CartInteractor.h"

@interface AppDependencies ()

@property (nonatomic, strong) LibraryWireframe *libraryWireframe;

@end

@implementation AppDependencies

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    [self configureDependencies];

    return self;
}

- (void)installRootViewControllerIntoWindow:(id)window
{
    [self.libraryWireframe presentLibraryInterfaceFromWindow:window];
}

- (void)configureDependencies
{
    // Root Level Classes
    LocalDataStore *localDataStore = [[LocalDataStore alloc] init];
    LocalCachedDataStore *localCachedDataStore = [[LocalCachedDataStore alloc] init];
    RemoteDataStore *remoteDataStore = [[RemoteDataStore alloc] init];
    RootWireframe *rootWireframe = [[RootWireframe alloc] init];
    AppReachability *appReachability = [[AppReachability alloc] init];

    // Library Module Classes
    LibraryWireframe *libraryWireframe = [[LibraryWireframe alloc] init];
    LibraryPresenter *libraryPresenter = [[LibraryPresenter alloc] init];
    LibraryDataManager *libraryDataManager = [[LibraryDataManager alloc] init];
    LibraryInteractor *libraryInteractor = [[LibraryInteractor alloc] initWithDataManager:libraryDataManager];

    // Cart Module Classes
    CartWireframe *cartWireframe = [[CartWireframe alloc] init];
    CartPresenter *cartPresenter = [[CartPresenter alloc] init];
    CartDataManager *cartDataManager = [[CartDataManager alloc] init];
    CartInteractor *cartInteractor = [[CartInteractor alloc] initWithDataManager:cartDataManager];

    // Library Module Dependencies
    libraryDataManager.localDataStore = localDataStore;
    libraryDataManager.localCachedDataStore = localCachedDataStore;
    libraryDataManager.remoteDataStore = remoteDataStore;
    libraryInteractor.output = libraryPresenter;
    libraryPresenter.libraryWireframe = libraryWireframe;
    libraryPresenter.libraryInteractor = libraryInteractor;
    libraryWireframe.libraryPresenter = libraryPresenter;
    libraryWireframe.rootWireframe = rootWireframe;
    libraryWireframe.cartWireframe = cartWireframe;

    // Cart Module Dependencies
    cartDataManager.localDataStore = localDataStore;
    cartDataManager.localCachedDataStore = localCachedDataStore;
    cartDataManager.remoteDataStore = remoteDataStore;
    cartInteractor.output = cartPresenter;
    cartPresenter.cartWireframe = cartWireframe;
    cartPresenter.cartInteractor = cartInteractor;
    cartWireframe.cartPresenter = cartPresenter;

    // Modules Delegate
    libraryPresenter.libraryModuleDelegate = cartPresenter;
    cartPresenter.cartModuleDelegate = libraryPresenter;

    appReachability.eventHandler = libraryInteractor;
    self.libraryWireframe = libraryWireframe;
}

@end
