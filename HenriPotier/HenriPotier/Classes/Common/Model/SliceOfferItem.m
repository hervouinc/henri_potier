//
//  SliceOfferItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 23/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "SliceOfferItem.h"

@interface SliceOfferItem ()

@property (nonatomic, copy) NSNumber* value;
@property (nonatomic, copy) NSNumber* sliceValue;

@end

@implementation SliceOfferItem

+ (instancetype)sliceOfferItemWithValue:(NSNumber *)value sliceValue:(NSNumber *)sliceValue
{
    SliceOfferItem *item = [[SliceOfferItem alloc] init];

    item.sliceValue = sliceValue;
    item.value = value;
    item.offerType = Slice;

    return item;
}

- (float)discountOnPrice:(float)price
{
    return ((int)(price/self.sliceValue.floatValue))*self.value.floatValue;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  OfferType: %ld  Value: %@  SliceValue: %@", [super description], self.offerType, self.value, self.sliceValue];
}

- (BOOL)isEqualToSliceOfferItem:(SliceOfferItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualOfferType = self.offerType == item.offerType;
    BOOL hasEqualValue = [self.value isEqualToNumber:item.value];
    BOOL hasEqualSliceValue = [self.sliceValue isEqualToNumber:item.sliceValue];

    return hasEqualOfferType && hasEqualValue && hasEqualSliceValue;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:SliceOfferItem.class])
    {
        return NO;
    }

    return [self isEqualToSliceOfferItem:object];
}

- (NSUInteger)hash
{
    return self.sliceValue.hash ^ self.value.hash;
}

@end
