//
//  LibraryDisplayDataCollector.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LibraryDisplayData;
@class BookItem;

@interface LibraryDisplayDataCollector : NSObject

- (void)addBookItems:(NSArray*)items;
- (void)updateBookItem:(BookItem *)item;
- (LibraryDisplayData*)collectedDisplayData;

@end
