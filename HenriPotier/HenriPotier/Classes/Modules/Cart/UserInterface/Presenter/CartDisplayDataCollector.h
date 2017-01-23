//
//  CartDisplayDataCollector.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartDisplayData;

@interface CartDisplayDataCollector : NSObject

- (void)addCartItems:(NSArray*)items;
- (CartDisplayData*)collectedDisplayData;


@end
