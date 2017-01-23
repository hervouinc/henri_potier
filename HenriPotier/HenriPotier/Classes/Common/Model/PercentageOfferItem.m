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

@end
