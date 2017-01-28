//
//  PercentageOfferItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 23/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "PercentageOfferItem.h"

@interface PercentageOfferItem ()

@property (nonatomic, copy) NSNumber* value;
@end

@implementation PercentageOfferItem

+ (instancetype)percentageOfferItemWithValue:(NSNumber *)value
{
    PercentageOfferItem *item = [[PercentageOfferItem alloc] init];

    item.value = value;
    item.offerType = Slice;

    return item;
}

- (float)discountOnPrice:(float)price
{
    return price*self.value.floatValue/100;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  OfferType: %ld  Value: %@", [super description], self.offerType, self.value];
}

- (BOOL)isEqualToPercentageOfferItem:(PercentageOfferItem *)item
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

    if (![object isKindOfClass:PercentageOfferItem.class])
    {
        return NO;
    }

    return [self isEqualToPercentageOfferItem:object];
}

- (NSUInteger)hash
{
    return self.value.hash;
}

@end
