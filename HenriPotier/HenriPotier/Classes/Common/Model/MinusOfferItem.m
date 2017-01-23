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

@end
