//
//  OfferItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "OfferItem.h"

@implementation OfferItem

- (float)discountOnPrice:(float)price
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)];
    return 0;
}

@end
