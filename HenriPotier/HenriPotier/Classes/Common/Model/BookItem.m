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
@end
