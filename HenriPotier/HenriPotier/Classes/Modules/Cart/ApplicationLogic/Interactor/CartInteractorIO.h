//
//  CartInteractorIO.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartItem;
@class OfferItem;

@protocol CartInteractorInput <NSObject>
- (void)findCartItems;
- (void)findBestOfferForCartItems:(NSArray<CartItem*>*)items;
- (void)addOneToCartItemWithIsbn:(NSString*)isbn;
- (void)removeOneToCartItemWithIsbn:(NSString*)isbn;
- (void)addToCartBookItemWithIsbn:(NSString*)isbn;
@end

@protocol CartInteractorOutput <NSObject>
- (void)foundCartItems:(NSArray<CartItem *> *)items;
- (void)foundBestOffer:(OfferItem *)offerItem forCartItems:(NSArray<CartItem *>*)items;
@end
