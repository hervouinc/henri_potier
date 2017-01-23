//
//  LibraryModuleInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LibraryModuleInterface <NSObject>

- (void)updateView;
- (void)goToCart;
- (void)addToCartBookWithIsbn:(NSString*)isbn;

@end
