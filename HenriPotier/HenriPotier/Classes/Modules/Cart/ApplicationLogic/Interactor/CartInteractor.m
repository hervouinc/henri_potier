//
//  CartInteractor.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartInteractor.h"
#import "CartDataManager.h"
#import "CartItem.h"
#import "BookItem.h"
#import "OfferItem.h"

@interface CartInteractor()
@property (nonatomic, strong) CartDataManager *dataManager;
@end

@implementation CartInteractor

- (instancetype)initWithDataManager:(CartDataManager *)dataManager
{
    self = [super init];
    if (!self) return nil;

    self.dataManager = dataManager;

    return self;
}

- (void)findCartItems
{
    __weak typeof(self) welf = self;

    [self.dataManager cartItemsWithCompletionBlock:^(NSArray<CartItem*> *cartItems) {
        [welf.output foundCartItems:cartItems];
    }];
}

- (void)findBestOfferForCartItems:(NSArray<CartItem *> *)items
{
    __weak typeof(self) welf = self;

    [welf.dataManager offerItemsWithIsbns:[self isbnsForCartItems:items] completionBlock:^(NSArray<OfferItem *> *results) {
        [welf.output foundBestOffer:[self bestOfferFromOfferItems:results andCartItems:items] forCartItems:items];
    }];
}

- (void)addOneToCartItemWithIsbn:(NSString *)isbn
{
    __weak typeof(self) welf = self;

    [self.dataManager addOneToCartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(item == nil)
        {
            [welf.dataManager addCartItemToCart:item];
        }
        [welf findCartItems];
    }];
}

- (void)removeOneToCartItemWithIsbn:(NSString *)isbn
{
    __weak typeof(self) welf = self;

    [self.dataManager removeOneToCartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(item.count.intValue <= 0)
        {
            [welf.dataManager removeCartItemFromCart:item];
        }
        [welf findCartItems];
    }];
}

- (void)addToCartBookItemWithIsbn:(NSString *)isbn
{
    __weak typeof(self) welf = self;

    [self.dataManager cartItemWithIsbn:isbn completionBlock:^(CartItem *item) {
        if(item == nil)
        {
            [welf.dataManager bookItemWithIsbn:isbn completionBlock:^(BookItem *item) {
                CartItem* cartItem = [CartItem cartItemWithBookItem:item count:@(1)];
                [welf.dataManager addCartItemToCart:cartItem];
                [welf findCartItems];
            }];
        }
        else
        {
            [welf addOneToCartItemWithIsbn:isbn];
        }
    }];
}

- (NSArray<NSString*>*)isbnsForCartItems:(NSArray<CartItem*>*)items
{
    __block NSMutableArray<NSString*>* isbns = [NSMutableArray array];
    [items enumerateObjectsUsingBlock:^(CartItem*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [isbns addObject:item.bookItem.isbn];
    }];
    return isbns;
}

- (OfferItem*)bestOfferFromOfferItems:(NSArray<OfferItem*>*)offerItems andCartItems:(NSArray<CartItem*>*)cartItems
{
    float totalPrice = [self totalPriceForCartItems:cartItems];
    float bestDiscount = 0;
    __block OfferItem *bestOffer = nil;
    [offerItems enumerateObjectsUsingBlock:^(OfferItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if([obj discountOnPrice:totalPrice] > bestDiscount)
        {
            bestOffer = obj;
        }
    }];
    return bestOffer;
}

- (float)totalPriceForCartItems:(NSArray<CartItem*>*)cartItems
{
    __block float totalPrice = 0;
    [cartItems enumerateObjectsUsingBlock:^(CartItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice += obj.bookItem.price.floatValue * obj.count.intValue;
    }];
    return totalPrice;
}

@end
