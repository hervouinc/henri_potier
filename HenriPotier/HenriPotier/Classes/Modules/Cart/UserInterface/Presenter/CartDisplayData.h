//
//  CartDisplayData.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CartDisplayItem;

@interface CartDisplayData : NSObject

@property (nonatomic, readonly, copy) NSArray<CartDisplayItem*>* items;

+ (instancetype)cartDisplayDataWithItems:(NSArray *)items;

@end
