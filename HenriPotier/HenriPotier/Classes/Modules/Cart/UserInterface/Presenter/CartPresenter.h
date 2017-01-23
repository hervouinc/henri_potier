//
//  CartPresenter.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LibraryModuleDelegateInterface.h"
#import "CartModuleInterface.h"
#import "CartInteractorIO.h"

@class CartWireframe;
@protocol CartViewInterface;
@protocol CartModuleDelegateInterface;

@interface CartPresenter : NSObject <CartInteractorOutput, CartModuleInterface, LibraryModuleDelegateInterface>

@property (nonatomic, weak) id<CartModuleDelegateInterface> cartModuleDelegate;

@property (nonatomic, strong) id<CartInteractorInput> cartInteractor;
@property (nonatomic, strong) CartWireframe *cartWireframe;
@property (nonatomic, strong) UIViewController<CartViewInterface> *userInterface;

@end
