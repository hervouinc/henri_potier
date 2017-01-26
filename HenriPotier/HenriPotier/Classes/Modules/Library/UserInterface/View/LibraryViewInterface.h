//
//  LibraryInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LibraryDisplayData;

@protocol LibraryViewInterface <NSObject>

- (void)showNoContentMessageWithError:(NSString*)error;
- (void)showLibraryDisplayData:(LibraryDisplayData *)data;
- (void)showNumberOfItemsInCart:(int)numberOfItemsInCart;
- (void)reloadEntries;

@end
