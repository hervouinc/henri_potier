//
//  CartDataManager.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RemoteDataStore;
@class LocalDataStore;
@class LocalCachedDataStore;
@class CartItem;
@class BookItem;
@class OfferItem;

typedef void(^CartDataManagerOfferItemsCompletionBlock)(NSArray<OfferItem*> *results);
typedef void(^CartDataManagerCartItemsCompletionBlock)(NSArray<CartItem*> *results);
typedef void(^CartDataManagerCartItemCompletionBlock)(CartItem *item);
typedef void(^CartDataManagerBookItemCompletionBlock)(BookItem *item);

@interface CartDataManager : NSObject

@property (nonatomic, strong) RemoteDataStore *remoteDataStore;
@property (nonatomic, strong) LocalDataStore *localDataStore;
@property (nonatomic, strong) LocalCachedDataStore *localCachedDataStore;

- (void)offerItemsWithIsbns:(NSArray<NSString*>*)isbns completionBlock:(CartDataManagerOfferItemsCompletionBlock)completionBlock;
- (void)cartItemsWithCompletionBlock:(CartDataManagerCartItemsCompletionBlock)completionBlock;

- (void)cartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock;
- (void)bookItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerBookItemCompletionBlock)completionBlock;

- (void)addOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock;
- (void)removeOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(CartDataManagerCartItemCompletionBlock)completionBlock;
- (void)addCartItemToCart:(CartItem *)cartItem;
- (void)removeCartItemFromCart:(CartItem *)cartItem;

@end
