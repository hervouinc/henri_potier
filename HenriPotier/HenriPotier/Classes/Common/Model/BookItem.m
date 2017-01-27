//
//  BookItem.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "BookItem.h"

@interface BookItem ()

@property (nonatomic, copy)   NSString*   title;
@property (nonatomic, copy)   NSString*   isbn;
@property (nonatomic, copy)   NSNumber*   price;
@property (nonatomic, copy)   NSString*   coverURL;

@end

@implementation BookItem

+ (instancetype)bookItemWithTitle:(NSString *)title isbn:(NSString *)isbn price:(NSNumber *)price coverURL:(NSString *)coverURL
{
    BookItem *item = [[BookItem alloc] init];

    item.title = title;
    item.isbn = isbn;
    item.price = price;
    item.coverURL = coverURL;

    return item;
}

+ (instancetype)bookItemWithTitle:(NSString *)title isbn:(NSString *)isbn price:(NSNumber *)price imageName:(NSString *)imageName
{
    BookItem *item = [[BookItem alloc] init];

    item.title = title;
    item.isbn = isbn;
    item.price = price;
    item.imageName = imageName;

    return item;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@  title: %@  isbn: %@  price: %@ coverURL:%@  imageName: %@", [super description], self.title, self.isbn, self.price, self.coverURL, self.imageName];
}

- (BOOL)isEqualToBookItem:(BookItem *)item
{
    if (!item)
    {
        return NO;
    }

    BOOL hasEqualTitles = [self.title isEqualToString:item.title];
    BOOL hasEqualIsbn = [self.isbn isEqualToString:item.isbn];
    BOOL hasEqualPrice = [self.price isEqualToNumber:item.price];
    BOOL hasEqualCover = (self.coverURL == item.coverURL) || [self.coverURL isEqualToString:item.coverURL];
    BOOL hasEqualImageName = (self.imageName == item.imageName) || [self.imageName isEqualToString:item.imageName];

    return hasEqualTitles && hasEqualIsbn && hasEqualPrice && hasEqualCover && hasEqualImageName;
}

- (BOOL)isEqual:(id)object
{
    if (self == object)
    {
        return YES;
    }

    if (![object isKindOfClass:BookItem.class])
    {
        return NO;
    }

    return [self isEqualToBookItem:object];
}

- (NSUInteger)hash
{
    return self.title.hash ^ self.isbn.hash ^ self.price.hash ^ self.coverURL.hash ^ self.imageName.hash;
}


@end
