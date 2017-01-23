//
//  LibraryService.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartItem;

typedef void(^LocalDataStoreFetchItemsCompletionBlock)(NSArray<CartItem*> *results);
typedef void(^LocalDataStoreFetchItemCompletionBlock)(CartItem *item);

@interface LocalDataStore : NSObject

- (void)fetchCartItemsWithCompletionBlock:(LocalDataStoreFetchItemsCompletionBlock)completionBlock;
- (void)fetchCartItemWithIsbn:(NSString*)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock;

- (void)addOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock;
- (void)removeOneToCartItemWithIsbn:(NSString*)isbn completionBlock:(LocalDataStoreFetchItemCompletionBlock)completionBlock;
- (void)addCartItem:(CartItem*)cartItem;
- (void)removeCartItem:(CartItem*)cartItem;

@end
