//
//  CartDisplayDataCollector.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartDisplayDataCollector.h"
#import "CartItem.h"
#import "CartDisplayData.h"
#import "CartDisplayItem.h"

@interface CartDisplayDataCollector()
@property (nonatomic, strong)   NSMutableArray* items;
@end

@implementation CartDisplayDataCollector

- (void)addCartItems:(NSArray *)items
{
    for (CartItem *item in items)
    {
        [self addCartItem:item];
    }
}

- (void)addCartItem:(CartItem *)item
{
    CartDisplayItem *displayItem = [self displayItemForCartItem:item];
    [self.items addObject:displayItem];
}

- (CartDisplayItem *)displayItemForCartItem:(CartItem *)item
{
    return [CartDisplayItem cartDisplayItemWithTitle:item.bookItem.title isbn:item.bookItem.isbn totalPrice:[self formattedTotalPriceForItemWithPrice:item.bookItem.price count:item.count]  imageName:item.bookItem.imageName count:item.count];
}

- (CartDisplayData *)collectedDisplayData
{
    return [CartDisplayData cartDisplayDataWithItems:self.items];
}

- (NSString *)formattedTotalPriceForItemWithPrice:(NSNumber*)price count:(NSNumber*)count
{
    return [NSString stringWithFormat:@"%.2f €", price.floatValue*count.intValue];
}

- (NSMutableArray *)items
{
    if(_items == nil)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
