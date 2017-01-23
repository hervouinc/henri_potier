//
//  LocalCachedDataStore.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 24/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookItem;

@interface LocalCachedDataStore : NSObject

- (BookItem *)bookItemWithIsbn:(NSString*)isbn;
- (void)setUpBookItems:(NSArray<BookItem*>*)bookItems;
- (NSArray<BookItem*>*)retrieveBookItems;

@end
