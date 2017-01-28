//
//  CartItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartItem.h"
#import "BookItem.h"

@interface CartItem ()

@property (nonatomic, strong)   BookItem*   bookItem;
@property (nonatomic, copy)   NSNumber*   count;

@end

@implementation CartItem

+ (instancetype)cartItemWithBookItem:(BookItem *)bookItem count:(NSNumber *)count
{
    CartItem *item = [[CartItem alloc] init];

    item.bookItem = bookItem;
    item.count = count;

    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  BookItem: %@  count: %@", [super description], self.bookItem, self.count];
}

- (BOOL)isEqualToCartItem:(CartItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualBookItem = [self.bookItem isEqual:item.bookItem];
    BOOL hasEqualCount = [self.count isEqualToNumber:item.count];

    return hasEqualBookItem && hasEqualCount;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:BookItem.class])
    {
        return NO;
    }

    return [self isEqualToCartItem:object];
}

- (NSUInteger)hash
{
    return self.bookItem.hash ^ self.count.hash;
}

@end
