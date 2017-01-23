//
//  LibraryDisplayData.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LibraryDisplayItem;

@interface LibraryDisplayData : NSObject

@property (nonatomic, readonly, copy) NSArray<LibraryDisplayItem*>* items;

+ (instancetype)libraryDisplayDataWithItems:(NSArray *)items;

@end
