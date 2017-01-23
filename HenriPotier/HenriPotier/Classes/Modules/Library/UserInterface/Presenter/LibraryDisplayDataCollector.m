//
//  LibraryDisplayDataCollector.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LibraryDisplayDataCollector.h"
#import "LibraryDisplayData.h"
#import "LibraryDisplayItem.h"
#import "BookItem.h"

@interface LibraryDisplayDataCollector()
@property (nonatomic, strong) NSMutableArray<LibraryDisplayItem*>* items;
@end

@implementation LibraryDisplayDataCollector

- (void)addBookItems:(NSArray *)items
{
    [items enumerateObjectsUsingBlock:^(BookItem*  _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        [self addBookItem:item];
    }];
}

- (void)updateBookItem:(BookItem *)item
{
    __block NSUInteger index = 0;
    __block BOOL found = NO;

    [self.items enumerateObjectsUsingBlock:^(LibraryDisplayItem*  _Nonnull displayItem, NSUInteger idx, BOOL * _Nonnull stop) {
        if([displayItem.isbn isEqualToString:item.isbn])
        {
            index = idx;
            found = YES;
            *stop = YES;
        }
    }];

    if(found)
    {
        self.items[index] = [self displayItemForBookItem:item];
    }
}

- (void)addBookItem:(BookItem *)item
{
    LibraryDisplayItem *displayItem = [self displayItemForBookItem:item];
    [self.items addObject:displayItem];
}

- (LibraryDisplayItem *)displayItemForBookItem:(BookItem *)item
{
    return [LibraryDisplayItem libraryDisplayItemWithTitle:item.title isbn:item.isbn price:[self formattedPriceForPrice:item.price] imageName:item.imageName];
}

- (LibraryDisplayData *)collectedDisplayData
{
    return [LibraryDisplayData libraryDisplayDataWithItems:self.items];
}

- (NSString *)formattedPriceForPrice:(NSNumber*)price
{
    return [NSString stringWithFormat:@"%.2f €", price.floatValue];
}

- (NSMutableArray *)items
{
    if(_items == nil)
    {
        _items = [NSMutableArray array];
    }
    return _items;
}

@end
