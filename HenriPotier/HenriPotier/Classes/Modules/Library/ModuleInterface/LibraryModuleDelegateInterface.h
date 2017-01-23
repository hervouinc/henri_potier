//
//  LibraryModuleDelegateInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 24/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LibraryModuleDelegateInterface <NSObject>

- (void)libraryModuleAddToCartBookWithIsbn:(NSString*)isbn;
- (void)libraryModuleAskForCartItemsCount;
@end
