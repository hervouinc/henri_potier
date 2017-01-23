//
//  CartModuleDelegateInterface.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 24/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CartModuleDelegateInterface <NSObject>

- (void)cartModuleDidUpdateCartItemsCount:(int)count;

@end
