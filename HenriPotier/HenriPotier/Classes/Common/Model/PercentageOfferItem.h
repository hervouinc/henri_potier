//
//  PercentageOfferItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 23/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferItem.h"

@interface PercentageOfferItem : OfferItem

@property (nonatomic, readonly, copy) NSNumber* value;

+ (instancetype)percentageOfferItemWithValue:(NSNumber*)value;

@end
