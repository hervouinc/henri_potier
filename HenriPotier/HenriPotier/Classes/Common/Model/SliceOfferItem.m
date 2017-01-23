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

@end
