//
//  CartDisplayItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "CartDisplayItem.h"

@interface CartDisplayItem ()

@property (nonatomic, copy)   NSString*   title;
@property (nonatomic, copy)   NSString*   isbn;
@property (nonatomic, copy)   NSString*   totalPrice;
@property (nonatomic, copy)   NSString*   imageName;
@property (nonatomic, copy)   NSNumber*   count;

@end

@implementation CartDisplayItem

+ (instancetype)cartDisplayItemWithTitle:(NSString*)title isbn:(NSString*)isbn totalPrice:(NSString*)totalPrice imageName:(NSString*)imageName count:(NSNumber *)count{
    CartDisplayItem *item = [[CartDisplayItem alloc] init];

    item.title = title;
    item.isbn = isbn;
    item.totalPrice = totalPrice;
    item.imageName = imageName;
    item.count = count;

    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  title: %@  isbn: %@  totalPrice: %@  imageName: %@  count: %@", [super description], self.title, self.isbn, self.totalPrice, self.imageName, self.count];
}

- (BOOL)isEqualToCartDisplayItem:(CartDisplayItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualTitles = [self.title isEqualToString:item.title];
    BOOL hasEqualIsbn = [self.isbn isEqualToString:item.isbn];
    BOOL hasEqualPrice = [self.totalPrice isEqualToString:item.totalPrice];
    BOOL hasEqualImageName = [self.imageName isEqualToString:item.imageName];
    BOOL hasEqualCount = [self.count isEqualToNumber:item.count];

    return hasEqualTitles && hasEqualIsbn && hasEqualPrice && hasEqualImageName && hasEqualCount;
}


- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:CartDisplayItem.class])
    {
        return NO;
    }

    return [self isEqualToCartDisplayItem:object];
}

- (NSComparisonResult)compare:(CartDisplayItem *)object
{
    return [self.title compare:object.title];
}

- (NSUInteger)hash
{
    return self.title.hash ^ self.isbn.hash ^ self.totalPrice.hash ^ self.imageName.hash ^ self.count.hash;
}


@end
