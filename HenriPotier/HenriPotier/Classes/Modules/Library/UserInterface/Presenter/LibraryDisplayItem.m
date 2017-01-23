//
//  LibraryDisplayItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryDisplayItem.h"

@interface LibraryDisplayItem()

@property (nonatomic, copy)   NSString*   title;
@property (nonatomic, copy)   NSString*   isbn;
@property (nonatomic, copy)   NSString*   price;
@property (nonatomic, copy)   NSString*   imageName;

@end

@implementation LibraryDisplayItem

+ (instancetype)libraryDisplayItemWithTitle:(NSString *)title isbn:(NSString *)isbn price:(NSString *)price imageName:(NSString *)imageName
{
    LibraryDisplayItem *item = [[LibraryDisplayItem alloc] init];
    item.title = title;
    item.isbn = isbn;
    item.price = price;
    item.imageName = imageName;

    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  title: %@  isbn: %@  price: %@  imageName: %@", [super description], self.title, self.isbn, self.price, self.imageName];
}

- (BOOL)isEqualToLibraryDisplayItem:(LibraryDisplayItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualTitles = [self.title isEqualToString:item.title];
    BOOL hasEqualIsbn = [self.isbn isEqualToString:item.isbn];
    BOOL hasEqualPrice = [self.price isEqualToString:item.price];
    BOOL hasEqualImageName = [self.imageName isEqualToString:item.imageName];

    return hasEqualTitles && hasEqualIsbn && hasEqualPrice && hasEqualImageName;
}


- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:LibraryDisplayItem.class])
    {
        return NO;
    }

    return [self isEqualToLibraryDisplayItem:object];
}

- (NSComparisonResult)compare:(LibraryDisplayItem *)object
{
    return [self.title compare:object.title];
}

- (NSUInteger)hash
{
    return self.title.hash ^ self.isbn.hash ^ self.price.hash ^ self.imageName.hash;
}

@end
