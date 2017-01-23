//
//  CartModuleInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 22/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CartModuleInterface <NSObject>

- (void)updateView;
- (void)didAddOneToCartItemWithIsbn:(NSString*)isbn;
- (void)didRemoveOneToCartItemWithIsbn:(NSString*)isbn;

@end
