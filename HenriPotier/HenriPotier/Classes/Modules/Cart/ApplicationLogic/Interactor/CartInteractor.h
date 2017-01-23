//
//  CartInteractor.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartInteractorIO.h"

@class CartDataManager;

@interface CartInteractor : NSObject <CartInteractorInput>

@property (nonatomic, weak)     id<CartInteractorOutput> output;

- (instancetype)initWithDataManager:(CartDataManager *)dataManager;

@end
