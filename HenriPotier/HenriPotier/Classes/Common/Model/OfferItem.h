//
//  OfferItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OfferType.h"

@interface OfferItem : NSObject

@property (nonatomic, assign) OfferType offerType;

- (float)discountOnPrice:(float)price;

@end
