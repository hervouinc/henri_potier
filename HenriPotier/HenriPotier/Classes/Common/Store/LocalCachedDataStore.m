//
//  LocalCachedDataStore.m
//  HenriPotier
//
//  Created by Cyril Hervouin on 24/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import "LocalCachedDataStore.h"
#import "BookItem.h"

@interface LocalCachedDataStore ()
@property (nonatomic, strong) NSDictionary<NSString*, BookItem*>* bookItems;
@end

@implementation LocalCachedDataStore

- (BookItem *)bookItemWithIsbn:(NSString*)isbn
{
    return self.bookItems[isbn];
}

- (void)setUpBookItems:(NSArray<BookItem*>*)bookItems
{
    __block NSMutableDictionary<NSString*, BookItem*>* dict = [NSMutableDictionary dictionary];
    [bookItems enumerateObjectsUsingBlock:^(BookItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dict[obj.isbn] = obj;
    }];
    self.bookItems = dict;
}

- (NSArray<BookItem *> *)retrieveBookItems
{
    return [self.bookItems allValues];
}

@end
