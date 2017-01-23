//
//  SliceOfferItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 23/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferItem.h"

@interface SliceOfferItem : OfferItem

@property (nonatomic, readonly, copy) NSNumber* value;
@property (nonatomic, readonly, copy) NSNumber* sliceValue;

+ (instancetype)sliceOfferItemWithValue:(NSNumber*)value sliceValue:(NSNumber*)sliceValue;

@end
