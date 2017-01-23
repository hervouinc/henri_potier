//
//  CartDisplayData.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartDisplayData.h"
#import "CartDisplayItem.h"

@interface CartDisplayData()
@property (nonatomic, copy) NSArray<CartDisplayItem*>* items;
@end

@implementation CartDisplayData

+ (instancetype)cartDisplayDataWithItems:(NSArray<CartDisplayItem*> *)items
{
    CartDisplayData* data = [[CartDisplayData alloc] init];

    data.items = [items sortedArrayUsingComparator:^NSComparisonResult(CartDisplayItem*  _Nonnull obj1, CartDisplayItem*  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];

    return data;
}

- (BOOL)isEqualToCartDisplayData:(CartDisplayData *)data
{
    if (!data)
    {
        return NO;
    }

    BOOL hasEqualItems = [self.items isEqualToArray:data.items];

    return hasEqualItems;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:[CartDisplayData class]])
    {
        return NO;
    }

    return [self isEqualToCartDisplayData:object];
}

- (NSUInteger)hash
{
    return self.items.hash;
}

@end
