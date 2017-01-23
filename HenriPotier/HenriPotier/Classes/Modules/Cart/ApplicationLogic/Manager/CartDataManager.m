//
//  CartDataManager.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartDataManager.h"
#import "RemoteDataStore.h"
#import "LocalDataStore.h"
#import "LocalCachedDataStore.h"
#import "CartItem.h"
#import "BookItem.h"

@implementation CartDataManager

- (void)offerItemsWithIsbns:(NSArray<NSString *> *)isbns completionBlock:(CartDataManagerOfferItemsCompletionBlock)completionBlock
{
    [self.remoteDataStore fetchOfferItemsForBookISBNs:isbns completionBlock:^(NSArray<OfferItem*> *entries) {
        if (completionBlock)
        {
            completionBlock(entries);
        }
    }];
}

- (void)cartItemsWithCompletionBlock:(CartDataManagerCartItemsCompletionBlock)completionBlock
{
    [self.localDataStore fetchCartItemsWithCompletionBlock:^(NSArray<CartItem*> *entries) {
        if(completionBlock)
        {
            completionBlock(entries);
        }
    }];
}

- (void)cartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock
{
    [self.localDataStore fetchCartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(completionBlock)
        {
            completionBlock(item);
        }
    }];
}

- (void)bookItemWithIsbn:(NSString *)isbn completionBlock:(CartDataManagerBookItemCompletionBlock)completionBlock
{
    BookItem *item = [self.localCachedDataStore bookItemWithIsbn:isbn];
    if(completionBlock)
    {
        completionBlock(item);
    }
}

- (void)addOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock
{
    [self.localDataStore addOneToCartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(completionBlock)
        {
            completionBlock(item);
        }
    }];
}

- (void)removeOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock
{
    [self.localDataStore removeOneToCartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(completionBlock)
        {
            completionBlock(item);
        }
    }];
}

- (void)addCartItemToCart:(CartItem *)cartItem
{
    [self.localDataStore addCartItem:cartItem];
}

- (void)removeCartItemFromCart:(CartItem *)cartItem
{
    [self.localDataStore removeCartItem:cartItem];
}

@end
