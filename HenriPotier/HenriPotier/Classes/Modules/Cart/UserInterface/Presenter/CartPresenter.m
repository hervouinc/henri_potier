//
//  CartPresenter.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartModuleDelegateInterface.h"
#import "CartPresenter.h"
#import "CartDisplayDataCollector.h"
#import "CartViewInterface.h"
#import "CartItem.h"
#import "OfferItem.h"

@implementation CartPresenter

- (void)updateView
{
    [self.cartInteractor findCartItems];
}

- (void)didAddOneToCartItemWithIsbn:(NSString *)isbn
{
    [self.cartInteractor addOneToCartItemWithIsbn:isbn];
}

- (void)didRemoveOneToCartItemWithIsbn:(NSString *)isbn
{
    [self.cartInteractor removeOneToCartItemWithIsbn:isbn];
}

#pragma mark - Library Interactor Output

- (void)foundCartItems:(NSArray<CartItem *> *)items
{
    if ([items count] == 0)
    {
        [self.userInterface showNoContentMessage];
    }
    else
    {
        [self.cartInteractor findBestOfferForCartItems:items];
        [self.userInterface showCartDisplayData:[self cartDisplayDataWithCartItems:items]];
    }

    [self.cartModuleDelegate cartModuleDidUpdateCartItemsCount:[self totalItemCountInCartItems:items]];

    [self.userInterface showTotalPrice:[NSString stringWithFormat:@"%.2f €", [self totalPriceForCartItems:items]]];
    [self.userInterface showOldTotalPrice:@""];
}

- (void)foundBestOffer:(OfferItem *)offerItem forCartItems:(NSArray<CartItem *> *)items
{
    if(offerItem == nil || items == nil)
    {
        return;
    }

    float totalPrice = [self totalPriceForCartItems:items];
    float discount = [offerItem discountOnPrice:totalPrice];

    [self.userInterface showTotalPrice:[NSString stringWithFormat:@"%.2f €", (totalPrice - discount)]];
    [self.userInterface showOldTotalPrice:[NSString stringWithFormat:@"%.2f €", totalPrice]];
}

- (CartDisplayData *)cartDisplayDataWithCartItems:(NSArray *)items
{
    CartDisplayDataCollector *collector = [[CartDisplayDataCollector alloc] init];
    [collector addCartItems:items];

    return [collector collectedDisplayData];
}

- (int)totalItemCountInCartItems:(NSArray<CartItem*>*)items
{
    __block int totalCount = 0;
    [items enumerateObjectsUsingBlock:^(CartItem*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        totalCount += item.count.intValue;
    }];
    return totalCount;
}

- (float)totalPriceForCartItems:(NSArray<CartItem*>*)items
{
    __block float totalPrice = 0;
    [items enumerateObjectsUsingBlock:^(CartItem*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        totalPrice += item.bookItem.price.floatValue*item.count.intValue;
    }];
    return totalPrice;
}

#pragma mark - LibraryModuleDelegate
- (void)libraryModuleAddToCartBookWithIsbn:(NSString *)isbn
{
    [self.cartInteractor addToCartBookItemWithIsbn:isbn];
}

- (void)libraryModuleAskForCartItemsCount
{
    [self.cartInteractor findCartItems];
}

@end
