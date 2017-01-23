//
//  CartViewInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartDisplayData;

@protocol CartViewInterface <NSObject>

- (void)showNoContentMessage;
- (void)showCartDisplayData:(CartDisplayData *)data;
- (void)showTotalPrice:(NSString*)totalPrice;
- (void)showOldTotalPrice:(NSString*)oldTotalPrice;
- (void)reloadEntries;

@end
