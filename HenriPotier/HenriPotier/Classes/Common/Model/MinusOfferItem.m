//
//  MinusOfferItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 23/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "MinusOfferItem.h"

@interface MinusOfferItem ()

@property (nonatomic, copy) NSNumber* value;

@end

@implementation MinusOfferItem

+ (instancetype)minusOfferItemWithValue:(NSNumber *)value
{
    MinusOfferItem *item = [[MinusOfferItem alloc] init];

    item.value = value;
    item.offerType = Slice;

    return item;
}

- (float)discountOnPrice:(float)price
{
    return self.value.floatValue;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  OfferType: %ld  Value: %@", [super description], self.offerType, self.value];
}

- (BOOL)isEqualToMinusOfferItem:(MinusOfferItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualOfferType = self.offerType == item.offerType;
    BOOL hasEqualValue = [self.value isEqualToNumber:item.value];

    return hasEqualOfferType && hasEqualValue;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:MinusOfferItem.class])
    {
        return NO;
    }

    return [self isEqualToMinusOfferItem:object];
}

- (NSUInteger)hash
{
    return self.value.hash;
}

@end
