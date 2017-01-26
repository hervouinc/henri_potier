//
//  LibraryInteractorIO.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BookItem;

@protocol LibraryInteractorInput <NSObject>
- (void)findBookItems;
@end

@protocol LibraryInteractorOutput <NSObject>
- (void)foundBookItems:(NSArray<BookItem*> *)items;
- (void)foundingBookItemsFailedWithError:(NSError*)error;
- (void)updatedBookItem:(BookItem *)item;
@end
