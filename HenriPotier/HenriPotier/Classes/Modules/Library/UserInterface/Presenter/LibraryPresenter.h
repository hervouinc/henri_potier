//
//  LibraryPresenter.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CartModuleDelegateInterface.h"
#import "LibraryModuleInterface.h"
#import "LibraryInteractorIO.h"

@class LibraryWireframe;
@protocol LibraryViewInterface;
@protocol LibraryModuleDelegateInterface;

@interface LibraryPresenter : NSObject <LibraryInteractorOutput, LibraryModuleInterface, CartModuleDelegateInterface>

@property (nonatomic, weak) id<LibraryModuleDelegateInterface> libraryModuleDelegate;

@property (nonatomic, strong) id<LibraryInteractorInput> libraryInteractor;
@property (nonatomic, strong) LibraryWireframe *libraryWireframe;
@property (nonatomic, strong) UIViewController<LibraryViewInterface> *userInterface;

@end
