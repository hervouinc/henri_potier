//
//  CartItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookItem.h"

@interface CartItem : NSObject

@property (nonatomic, readonly, strong)   BookItem* bookItem;
@property (nonatomic, readonly, copy)   NSNumber* count;

+ (instancetype)cartItemWithBookItem:(BookItem*)bookItem count:(NSNumber*)count;

@end
