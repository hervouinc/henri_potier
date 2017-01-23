//
//  CartItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartItem.h"
#import "BookItem.h"

@interface CartItem ()

@property (nonatomic, strong)   BookItem*   bookItem;
@property (nonatomic, copy)   NSNumber*   count;

@end

@implementation CartItem

+ (instancetype)cartItemWithBookItem:(BookItem *)bookItem count:(NSNumber *)count
{
    CartItem *item = [[CartItem alloc] init];

    item.bookItem = bookItem;
    item.count = count;

    return item;
}

@end
