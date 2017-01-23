//
//  LibraryDisplayItem.h
//  HenriPotier
//
//  Created by Cyril Hervouin on 21/01/2017.
//  Copyright © 2017 Hervouin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LibraryDisplayItem : NSObject

@property (nonatomic, readonly, copy)   NSString*   title;
@property (nonatomic, readonly, copy)   NSString*   isbn;
@property (nonatomic, readonly, copy)   NSString*   price;
@property (nonatomic, readonly, copy)   NSString*   imageName;

+ (instancetype)libraryDisplayItemWithTitle:(NSString*)title isbn:(NSString*)isbn price:(NSString*)price imageName:(NSString*)imageName;

- (NSComparisonResult)compare:(LibraryDisplayItem *)object;

@end
